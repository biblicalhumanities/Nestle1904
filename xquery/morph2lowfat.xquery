(:
  Convert Ulrik's morphology to words in Lowfat format.

  Use Lowfat conventions in preference to Robinson's for now,
  but don't lose information that is easily comparable or
  easily incorporated.
:)

declare function local:tense-attribute($t)
{
  attribute tense {
        switch($t)
          case 'P'
            return 'present'
          case 'I'
            return 'imperfect'
          case 'F'
            return 'future'
          case 'R'
            return 'perfect'
          case 'A'
            return 'aorist'
          case 'L'
            return 'pluperfect'
          case 'X'
            return 'none'
          default
            return '###'
  }
};

declare function local:voice-attribute($v)
{
  attribute voice {
      switch($v)
        case  'A'
          return 'active'
        case 'M'
          return 'middle'
        case 'P'
          return 'passive'
        case 'D'
          return 'middlepassive'
        case 'O'
          return 'middlepassive'
        case 'Q'
          return 'active'
        case 'E'
          return 'middlepassive'
        case 'N'
          return 'middlepassive'
        case 'X'
          return 'active'
        default
          return '### ' || $v
  }
};

declare function local:mood-attribute($t)
{
  attribute mood {
    switch($t)
      case 'I'
        return 'indicative'
      case 'S'
        return 'subjunctive'
      case 'O'
        return 'optative'
      case 'M'
        return 'imperative'
      case 'N'
        return 'infinitive'
      case 'P'
      case 'R'
        return 'participle'
      default
        return '###'
  }
};

declare function local:case-attribute($c)
{
  attribute case {
      switch ($c)
        case 'N' return 'neuter'
        case 'G' return 'genitive'
        case 'D' return 'dative'
        case 'A' return 'accusative'
        case 'V' return 'vocative'
        default return '###'
  }
};

declare function local:person-attribute($p)
{
  attribute person {
    switch ($p)
      case "1"
        return "first"
      case "2"
        return "second"
      case "3"
        return "third"
      default
        return "###"
  }
};

declare function local:number-attribute($n)
{
  attribute number {
      switch ($n)
        case 'S' return 'singular'
        case 'P' return 'plural'
        default return '###'
  }
};

declare function local:gender-attribute($g)
{
  attribute gender {
      switch ($g)
        case 'M' return 'masculine'
        case 'F' return 'feminine'
        case 'N' return 'neuter'
        default return '###'
  }
};

declare function local:pcn-attributes($pcn)
{
  local:person-attribute(substring($pcn,1,1)),
  local:case-attribute(substring($pcn,2,1)),
  local:number-attribute(substring($pcn,3,1))
};

declare function local:cng-attributes($cng)
{
  local:case-attribute(substring($cng,1,1)),
  local:number-attribute(substring($cng,2,1)),
  local:gender-attribute(substring($cng,3,1))
};

declare function local:tvm-attributes($tvm)
{
  let $tvm := replace($tvm, '2', '')
  return
    local:tense-attribute(substring($tvm,1,1)),
    local:voice-attribute(substring($tvm,2,1)),
    local:mood-attribute(substring($tvm,3,1))
};


declare function local:pn-attributes($pn)
{
  local:person-attribute(substring($pn,1,1)),
  local:number-attribute(substring($pn,2,1))
};

declare function local:pronoun-attributes($class, $pncng)
{
  switch ($class)
    case 'P'
    case 'R'
      return
        if (substring($pncng, 1, 1) = ('1', '2', '3'))
          then (
            local:person-attribute(substring($pncng, 1, 1)),
            local:case-attribute(substring($pncng, 2, 1)),
            local:number-attribute(substring($pncng, 3, 1)))                
          else (
            local:case-attribute(substring($pncng, 1, 1)),
            local:number-attribute(substring($pncng, 2, 1)),
            local:gender-attribute(substring($pncng, 3, 1)))            
    case 'C'
    case 'D'
    case 'K' 
    case 'I'    
    case 'X'
    case 'Q'    
      return (
        local:case-attribute(substring($pncng, 1, 1)),
        local:number-attribute(substring($pncng, 2, 1)),
        local:gender-attribute(substring($pncng, 3, 1)))        
    case 'F'
      return (
        local:person-attribute(substring($pncng, 1, 1)),      
        local:case-attribute(substring($pncng, 2, 1)),
        local:number-attribute(substring($pncng, 3, 1)),
        local:gender-attribute(substring($pncng, 4, 1)))     
    case 'S'
      return (
        (: ### Drops number of the possessor! ### :)
        local:person-attribute(substring($pncng, 1, 1)),      
        local:case-attribute(substring($pncng, 3, 1)),
        local:number-attribute(substring($pncng, 4, 1)),
        local:gender-attribute(substring($pncng, 5, 1)))
    default 
      return (
        attribute a {$class},
        attribute b {$pncng}
      )
};

declare function local:parse-attributes($morph)
{
    switch(local:firstclass($morph))
      case 'verb' return
        let $tvm := tokenize($morph, '-')[2] ! replace (., '2', '')
        let $rest :=  tokenize($morph, '-')[3]  (: ignore verb-extra :)
        let $mood := substring($tvm, 3, 1)
        return (
          local:tvm-attributes($tvm),
          switch ($mood)
            case 'I'
            case 'S'
            case 'O'
            case 'M'
              return local:pn-attributes($rest)
            case 'N'
              return ()
            case 'P'
            case 'R'
              return local:cng-attributes($rest)
            default
              return attribute error {$rest}
        )
      case 'pron'
        return
          let $class := tokenize($morph, '-')[1]
          let $pncng := tokenize($morph, '-')[2]
          return local:pronoun-attributes($class, $pncng)
      case 'noun'
      case 'det'
        return
          let $cng := tokenize($morph, '-')[2]
          where $cng and not($cng = ('PRI','OI','LI', ''))
          return local:cng-attributes($cng)
      case '###'
        return
          let $pcn := tokenize($morph, '-')[2]
          return local:pcn-attributes($pcn)
      default
        return ()
};

declare function local:firstclass($morph)
{
    switch (substring($morph, 1, 1))
      case "N" return "noun"
      case "V" return "verb"
      case "A" return "adj"
      case "T" return "det"
      case "P" return "pron"
      case "R" return "pron"
      case "C" return "pron"
      case "D" return "pron"
      case "K" return "pron"
      case "I" return "pron"
      case "X" return "pron"
      case "Q" return "pron"
      case "F" return "pron"
      case "S" return "pron"

      default return "###" || $morph
};


declare function local:type($morph)
{
  switch ($morph)
    case 'N-PRI' return ()
    case 'A-NUI' return 'numeral'
    case 'N-LI' return 'letter'
    case 'N-OI' return ()
    case 'COND' return 'conditional'
    default return
      switch(substring($morph, 1, 2))
        case 'P-' return 'personal'
        case 'R-' return 'relative'
        case 'C-' return 'reciprocal'
        case 'D-' return 'demonstrative'
        case 'K-' return 'correlative'
        case 'I-' return 'interrogative'
        case 'X-' return 'indefinite'
        case 'Q-' return 'interrogative or correlative ###'
        case 'F-' return 'reflexive'
        case 'S-' return 'possessive'
        default return  ()
};


declare function local:class($morph)
{
  switch ($morph)
    case 'CONJ'
    case 'CONJ-N'
      return 'conj'
    case 'PREP'
      return 'prep'
    case 'ADV'
    case 'ADV-I'
    case 'ADV-N'
    case 'ADV-K'
    case 'ADV-S'
    case 'ADV-C'
      return 'adv'
    case 'PRT'
    case 'PRT-I'
    case 'PRT-N'
      return 'ptcl'
    case 'INJ'
      return 'intj'
    case 'HEB'
      return 'hebrew'
    case 'ARAM'
      return 'aramaic'
    case
      'COND' return 'conj'
    case
      'A-NUI' return 'adj'  (: but declinable numbers are treated as adjectives in Lowfat :)
    default
      return local:firstclass($morph)
};

declare function local:osisId($bcv, $seq)
{
  translate($bcv, ' ', '.') ! translate(., ':', '.' ) || "!" || $seq
};

declare function local:verse($records)
{
  for $r at $i in $records
  let $form := $r/form_morph ! string(.)
  let $class :=  local:class($form)
  return
    <w>
      {
        attribute class { $class },
        local:type($form) ! attribute type { . },
        attribute osisId { $r/BCV ! local:osisId(., $i) },
        attribute lemma { $r/lemma },
        attribute normalized { $r/normalized },
        attribute strong { $r/strongs },
        local:parse-attributes($form),
        attribute form {$form },
        attribute func { $r/func_morph},
        $r/text ! string(.)
      }
    </w>
};

<text>
{
  for tumbling window $verse in //record
      start $first when fn:true()
      end next $next when  $first/BCV != $next/BCV
  return local:verse($verse)  
}
</text>

