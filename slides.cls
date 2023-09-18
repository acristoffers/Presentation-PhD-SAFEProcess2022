% !TeX program = xelatex
% !TeX encoding = UTF-8 Unicode
% !BIB program = bibtex

% Declaration for this class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{slides}[2020/04/21 Modelo de Apresentação de Slides em XeLaTeX]

% Base our class on Beamer
\LoadClass[8pt,t,compress,usenames,dvipsnames,aspectratio=169]{beamer}
\RequirePackage[english,french,brazil]{babel}

% Declares options accepted by this class. No \RequirePackage allowed from now
% on. Since we cannot \RequirePackage inside \DeclareOption, we have to create a
% variable to hold whether the package should be loaded.

\newif\if@langen
\newif\if@langfr
\newif\if@useminted

\DeclareOption{abnt}{\PassOptionsToPackage{style=abnt}{biblatex}}
\DeclareOption{ieee}{\PassOptionsToPackage{style=ieee}{biblatex}}
\DeclareOption{english}{\@langentrue}
\DeclareOption{french}{\@langfrtrue}

% Processes all options and puts us back into normal mode. \RequirePackage
% allowed again.
\ProcessOptions\relax

\if@langfr
  \RequirePackage[output-decimal-marker=,,
    input-complex-root=i,
    output-complex-root=i,
    complex-root-position=after-number]{siunitx} % SI units
\else
  \if@langen
    \RequirePackage[output-decimal-marker=.,
      input-complex-root=i,
      output-complex-root=i,
      complex-root-position=after-number]{siunitx} % SI units
  \else
    \RequirePackage[output-decimal-marker=,,
      input-complex-root=i,
      output-complex-root=i,
      complex-root-position=after-number]{siunitx} % SI units
  \fi
\fi

% Basic
\RequirePackage[no-math]{fontspec}
\RequirePackage{unicode-math}
\RequirePackage[backend=biber]{biblatex}
\RequirePackage[useregional]{datetime2}
\RequirePackage{float}
\RequirePackage{framed}
\RequirePackage{etoolbox}
\RequirePackage{pgffor}

% Image manipulation
\RequirePackage{graphicx} % For images
\RequirePackage{rotate} % To rotate images
\RequirePackage[section]{placeins} % Prevents figures from floating to wrong places
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage[european,cuteinductors,smartlabels,oldvoltagedirection]{circuitikz} % For circuits

% Math related
\RequirePackage{amssymb}
\RequirePackage{amsmath} % Mathematic symbols and stuff
\RequirePackage{amsfonts} % Mathematical fonts
\RequirePackage{cancel} % In math mode, variables to strike
\RequirePackage{subscript} % For subscript
\RequirePackage{accents}

% Table manipulation
\RequirePackage{multirow} % Multirow tables
\RequirePackage{tabulary} % Table tabulation
\RequirePackage{array}
% Makes the column type L, that is centered and allows line wrap.
\newcolumntype{L}{>{\centering\arraybackslash}m{3cm}}

% Utilities
\RequirePackage{pdfpages} % Advanced PDF importing
\RequirePackage{chngcntr} % Change numberings
\RequirePackage{csquotes} % \enquote
\RequirePackage{url}
\RequirePackage{ragged2e} % Justify
\RequirePackage[absolute, overlay]{textpos} % \textblock
\RequirePackage{pifont}

% Template Configuration
\defaultfontfeatures{Ligatures=TeX}
\usetheme{Dresden}
\usefonttheme{serif,professionalfonts}
\setmainfont{DejaVu Sans}
\setmathfont{Latin Modern Math}
\setmonofont{JetBrainsMono Nerd Font Mono}
\setmathrm{Latin Modern Math}

\setbeamertemplate{headline}
{
  \begin{beamercolorbox}[colsep=1.5pt]{upper separation line head}
  \end{beamercolorbox}
  \begin{beamercolorbox}{section in head/foot}
    \vskip2pt%
    \insertsectionnavigationhorizontal{\textwidth}{}{}%
    \insertsubsectionnavigationhorizontal{\textwidth}{}{}%
    \vskip2pt
  \end{beamercolorbox}%
  \begin{beamercolorbox}[colsep=1.5pt]{middle separation line head}
  \end{beamercolorbox}
  \begin{beamercolorbox}[ht=2.5ex,dp=1.125ex,%
      leftskip=.3cm,rightskip=.3cm plus1fil]{subsection in head/foot}
    \usebeamerfont{subsection in head/foot}\insertsubsectionhead{}
  \end{beamercolorbox}%
  \begin{beamercolorbox}[colsep=1.5pt]{lower separation line head}
  \end{beamercolorbox}
}

\setbeamertemplate{footline} {
  \begin{center}
    \insertframenumber/\inserttotalframenumber{}
  \end{center}
}

\setbeamercovered{dynamic}

%%% Specific Commands

\newcounter{authors}
\newcommand\addauthor[2]{%
  \stepcounter{authors}%
  \csdef{author\theauthors}{#1}%
  \csdef{authoremail\theauthors}{#2}%
}
\newcommand\getauthor[1]{\csuse{author#1}}
\newcommand\getauthoremail[1]{\csuse{authoremail#1}}
\newcommand\getauthors{\foreach \i in {1,...,\theauthors}{\getauthor{\i}\\\small{(\getauthoremail{\i})}\ifnum\i=\theauthors\@\else\\\ \fi}}
\newcommand\getauthornames{\foreach \i in {1,...,\theauthors}{\getauthor{\i}\ifnum\i=\theauthors\@\else,\ \fi}}

\newcommand\setorientador[1]{\csdef{getorientador}{#1}}

\newcounter{coorientador}
\newcommand\addcoorientador[1]{%
  \stepcounter{coorientador}%
  \csdef{coorientador\thecoorientador}{#1}%
}
\newcommand\getcoorientador[1]{\csuse{coorientador#1}}
\newcommand\getcoorientadores{\foreach \i in {1,...,\thecoorientador}{\getcoorientador{\i}\ifnum\i=\thecoorientador\@\else,\ \fi}}

\newcounter{membrobanca}
\newcommand\addmembrobanca[1]{%
  \stepcounter{membrobanca}%
  \csdef{membrobanca\themembrobanca}{#1}%
}
\newcommand\getmembrobanca[1]{\csuse{membrobanca#1}}
\newcommand\getmembrosbanca{\foreach \i in {1,...,\themembrobanca}{\getmembrobanca{\i}\ifnum\i=\themembrobanca\@\else,\ \fi}}

\newcommand\setlocal[1]{\csdef{local}{#1}}
\newcommand\setmes[1]{\csdef{mes}{#1}}
\newcommand\setano[1]{\csdef{ano}{#1}}
\newcommand\setdepartamento[1]{\csdef{departamento}{#1}}
\newcommand\seteixodeformacao[1]{\csdef{eixodeformacao}{#1}}

\newcommand\preamble{%
  \usetikzlibrary{backgrounds,shapes,arrows,positioning,fit,intersections,calc}%
  \graphicspath{{imgs/}}%
  \hypersetup{
    unicode=true,
    pdftitle={\@title},
    pdfauthor={\getauthor{1}},
    pdfstartview={FitH}
  }%
}

\newcommand{\addlogo}{
  \begin{textblock}{2}(0.5,14.5)
    \includegraphics[height=0.5cm]{imgs/urca}
  \end{textblock}
  \begin{textblock*}{\textwidth}(50pt,240pt)
    \begin{flushright}
      \footnotesize{Álan e Sousa}
    \end{flushright}
  \end{textblock*}
}

\newenvironment{slide}[2][t]
{
  \begin{frame}[#1]{#2}
    \addlogo{}
    \vspace*{\fill}
    }
    {
    \vspace*{\fill}
  \end{frame}
}

\renewcommand{\maketitle}{
  \if@langfr
    \selectlanguage{french}%
    \sisetup{locale=FR}%
  \else
    \if@langen
      \selectlanguage{english}%
      \sisetup{locale=US}%
    \else
      \selectlanguage{brazil}%
      \sisetup{locale=DE}%
    \fi
  \fi
  \setbeamercovered{invisible}
  {
    \usebackgroundtemplate{\includegraphics[width=\paperwidth]{imgs/cover}}
    \begin{frame}[plain,t]
      \vbox{}
      \vskip2cm%
      \begingroup
      \centering
      \begin{beamercolorbox}[sep=8pt,center]{title}
        \usebeamerfont{title}\inserttitle\par%
        \ifx\insertsubtitle\@empty%
        \else%
          \vskip0.25em%
          {\usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}\insertsubtitle\par}%
        \fi%
      \end{beamercolorbox}%
      \begin{beamercolorbox}[sep=8pt,center]{author}
        \usebeamerfont{author}\getauthors
      \end{beamercolorbox}

      \vfill

      \departamento

      \vfill

      \includegraphics[height=1cm]{imgs/urca}

      \vfill

      \tiny{
        Supervisor: \getorientador{}\\
        Cosupervisor: \getcoorientadores{}
      }

      \vfill

      \begin{beamercolorbox}[sep=8pt,center]{date}
        \usebeamerfont{date}\local{}\\\mes{}~\ano{}
      \end{beamercolorbox}\vskip0.5em
      \endgroup

      \vfill
    \end{frame}
  }
}
