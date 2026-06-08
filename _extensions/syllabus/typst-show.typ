#show: doc => syllabus(
// Course metadata
$if(title)$
  title: [$title$],
  title-meta: "$if(title-meta)$$title-meta$$else$$title$$endif$",
$endif$
$if(number)$
  number: [$number$],
$endif$
$if(institution)$
  institution: [$institution$],
$endif$
$if(semester)$
  semester: [$semester$],
$endif$
$if(by-author)$
$for(by-author)$
$if(it.name.literal)$
  instructor: [$it.name.literal$],
  author-meta: "$it.name.literal$",
$if(it.email)$
  email: [$it.email$],
$endif$
$endif$
$endfor$
$endif$
$if(time)$
  time: [$time$],
$endif$
$if(place)$
  place: [$place$],
$endif$
$if(office-hours)$
  office-hours: [$office-hours$],
$endif$
$if(tas)$
  tas: ($for(tas)$(name: [$it.name$]$if(it.email)$, email: [$it.email$]$endif$$if(it.office-hours)$, office-hours: [$it.office-hours$]$endif$),$endfor$),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(header)$
  header: [$header$],
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
