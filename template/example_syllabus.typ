// Standalone Typst syllabus example for bjk-academic.
//
// Usage from this repo:
//   typst compile template/example_syllabus.typ --root . --font-path static/fonts
//
// Usage as a local package (after symlinking into
// ~/.local/share/typst/packages/local/bjk-academic/0.1.0/):
//   #import "@local/bjk-academic:0.1.0": syllabus

#import "../lib.typ": syllabus

#show: syllabus.with(
  title: "War and State Development",
  number: "PSCI 2227",
  institution: "Vanderbilt University",
  semester: "Spring 2026",
  instructor: "Professor Brenton Kenkel",
  email: "brenton.kenkel@vanderbilt.edu",
  time: [Mondays & Wednesdays, 2:20--3:45pm],
  place: "Alumni Hall 201",
  office-hours: [Tuesdays 2:00--3:30pm, Commons Center 326],
  tas: (
    (
      name: "Seungho Song",
      email: "seung.ho.song@vanderbilt.edu",
      office-hours: [Fridays 3:00--4:30pm, Commons 317],
    ),
  ),
)

"War made the state, and the state made war."\
---Charles Tilly, 1975

In this course, we will examine how war has affected the development of major
political and economic institutions. We will work through theoretical models of
war's role in state development, and we will use historical and statistical
evidence to evaluate the explanatory power of these models.

Some key challenges will arise repeatedly throughout the semester. How can we
establish cause-and-effect relationships when we cannot run randomized
experiments and must rely solely on historical evidence? And even if we
establish that war shaped a specific institutional development in a specific
state, how much can we generalize to other times and places? We will learn how
to address questions like these.

The key logistics above come from the `time`, `place`, `office-hours`, and `tas`
metadata. I try to respond to all student email within one business day, and you
don't need an appointment for office hours --- just show up.

= Grading

*Daily reading quizzes (20%).*
Each class session will begin with a brief quiz about the content of that day's
readings. These quizzes are designed to ensure you have absorbed the main
argument of the readings --- no trivia or gotcha questions. Your four lowest quiz
scores, including any quizzes that you miss, will be dropped before calculating
your final grade.

*Exams (15% midterm, 20% final).*
There will be an in-class midterm and final exam. Each exam will be evenly
divided between short answer questions and a longer-format essay. Exams are
open-notes, but you will need to print those notes --- no electronic devices
during exams. The final exam will be cumulative.

*Research project (5% proposal, 15% first draft, 25% final draft).*
Outside of class, you will complete a research project that advances a
theoretical argument about the effects of warfare on some aspect of state
development, then uses historical evidence to test that argument. The empirical
test may take the form of process tracing, a small-N case comparison, or
quantitative data analysis.

*Extra credit.*
There will be two opportunities for extra credit. One will involve your personal
participation in a research study with the RIPS Lab. The other will involve
collective participation in the end-of-semester course evaluations.

= Schedule

All readings will be available on Brightspace. For each reading, I'll provide a
reading guide with questions to help walk you through the reading and extract the
most important information.

#table(
  columns: (auto, auto, 1fr),
  table.header([Topic], [Date], [Reading]),

  [Intro to the course], [Mon Jan 5], [No readings],

  [The sovereign state], [Wed Jan 7], [@spruyt1994institutional],
  [], [Mon Jan 12], [@olson1993dictatorship],
  [], [Wed Jan 14], [@sanchez2020origins],
  [], [Mon Jan 19], [_No class --- MLK Day_],

  [Territorial control], [Wed Jan 21], [@tilly1990coercion[ch. 3]],
  [], [Mon Feb 2], [@abramson2017economic],
  [], [Wed Feb 4], [@thies2005war],
  [], [Mon Feb 9], [@dincecco2018violent],
  [], [Wed Feb 11], [Proposal writing workshop],

  [Raising revenue], [Mon Feb 16], [@levi1988rule[ch. 2]],
  [], [Wed Feb 18], [@karaman2013different],
  [], [Fri Feb 20], [*Research proposal due*],
  [], [Mon Feb 23], [@queralt2019war],

  [Parliaments], [Wed Feb 25], [@kenkel2023theory],
  [], [Mon Mar 2], [*Midterm exam*],
  [], [Wed Mar 4], [@cox2023window],

  [Democratization], [Mon Mar 16], [@acemoglu2000did],
  [], [Wed Mar 18], [@przeworski2009conquered],
  [], [Fri Mar 20], [*First draft of research paper due*],
  [], [Mon Mar 23], [@blattman2009violence],

  [Nationalism], [Wed Mar 25], [@anderson1983imagined[ch. 1--2]],
  [], [Mon Mar 30], [@sambanis2015nation],
  [], [Wed Apr 1], [@darden2016threats],

  [Bureaucracy], [Mon Apr 13], [@brewer1988sinews[ch. 3--4]],
  [], [Wed Apr 15], [@chen2023state],

  [], [Fri Apr 17], [*Final research paper + revision memo due*],
  [], [Thur Apr 23], [*Final exam*],
)

= References

#bibliography("syllabus-references.bib", title: none)
