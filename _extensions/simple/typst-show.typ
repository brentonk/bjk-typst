#show: doc => simple(
// Document metadata
$if(title)$
  title: [$title$],
  title-meta: "$if(title-meta)$$title-meta$$else$$title$$endif$",
$endif$
$if(by-author)$
  author: [$for(by-author)$$it.name.literal$$sep$, $endfor$],
  author-meta: "$for(by-author)$$it.name.literal$$sep$, $endfor$",
$endif$
$if(date)$
  date: [$date$],
$endif$
// Layout settings
$if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
$endif$
$if(papersize)$
  paper: "$papersize$",
$endif$
// Typography settings
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(sansfont)$
  sansfont: ("$sansfont$",),
$endif$
$if(mathfont)$
  mathfont: ("$mathfont$",),
$endif$
// Structure settings
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
$if(toc)$
  toc: $toc$,
$endif$
  doc,
)
