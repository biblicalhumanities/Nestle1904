(:
    This query converts a Berean spreadsheet into XML with osisIds.
    
    Save the spreadsheet as .csv, import it using a tool that creates elements using column names
    (e.g. oXygen's import), and run this query on the result.
    
    About 10 osisIds will fail, with ### as part of the name.  Edit those by hand.
:)

declare function local:osisBook($bereanBook)
{
    switch ($bereanBook)
        case "Matthew"
            return
                "Matt"
        case "Mark"
            return
                "Mark"
        case "Luke"
            return
                "Luke"
        case "John"
            return
                "John"
        case "Acts"
            return
                "Acts"
        case "Romans"
            return
                "Rom"
        case "1Corinthians"
            return
                "1Cor"
        case "2Corinthians"
            return
                "2Cor"
        case "Galatians"
            return
                "Gal"
        case "Ephesians"
            return
                "Eph"
        case "Philippians"
            return
                "Phil"
        case "Colossians"
            return
                "Col"
        case "1Thessalonians"
            return
                "1Thess"
        case "2Thessalonians"
            return
                "2Thess"
        case "1Timothy"
            return
                "1Tim"
        case "2Timothy"
            return
                "2Tim"
        case "Titus"
            return
                "Titus"
        case "Philemon"
            return
                "Phlm"
        case "Hebrews"
            return
                "Heb"
        case "James"
            return
                "Jas"
        case "1Peter"
            return
                "1Pet"
        case "2Peter"
            return
                "2Pet"
        case "1John"
            return
                "1John"
        case "2John"
            return
                "2John"
        case "3John"
            return
                "3John"
        case "Jude"
            return
                "Jude"
        case "Revelation"
            return
                "Rev"
        default return
            "###"
};

declare function local:osisId($bereanVerse, $word)
{
    let $tokens := tokenize($bereanVerse, "\|")
    let $chapverse := replace($tokens[last()], ":", ".")
    let $book := string-join($tokens[position() < last()], "")
    return concat(local:osisBook($book), ".", $chapverse, "!", $word)
};

<root>
{
for $r in //record
let $verse.num := $r/Verse_Num
group by $verse.num
order by $verse.num
return
    <verse>
        {
            attribute verse {$r[1]/Verse[1]},
            attribute vnum {$verse.num}
        }
        {
            for $r in $r
            where $r/Nestle_1904_sort != ""
            order by xs:decimal($r/$r/Nestle_1904_sort)
            count $i
            return
                <w>
                    {
                        attribute word {$i},
                        attribute sort { $r/Nestle_1904_sort},
                        attribute osisId { local:osisId($r/KJV_Verse[1], $i) },
                        element greek {$r/Nestle_1904 ! normalize-space(.)},
                        element gloss {$r/Biblos_Gloss ! normalize-space(.)}
                    }
                </w>
        }
    </verse>
}</root>
