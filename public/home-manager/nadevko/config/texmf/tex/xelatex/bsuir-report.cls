\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bsuir-report}[2023/09/19 BSUIR report class]

\LoadClass[14pt]{extarticle}
\RequirePackage[a4paper, top=20mm, right=15mm, bottom=27mm, left=30mm]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[main=russian, english]{babel}

\RequirePackage{fontspec}
\setmainfont{Times New Roman}
\setsansfont{Times New Roman}
\setmonofont{Times New Roman}
\RequirePackage{iflang}
\newcommand{\makeinttext}[3]{\IfLanguageName{belarusian}{#2}{\IfLanguageName{russian}{#3}{#1}}}
\RequirePackage{titlesec}
\RequirePackage{xparse}

\setlength{\parindent}{0cm}
\setlength{\parskip}{.25cm}

\RequirePackage{minted}
\RequirePackage{svg}
\RequirePackage{graphicx}

\newcommand{\department}[1]{\def\@departament{#1}}
\newcommand{\worktype}[1]{\def\@worktype{#1}}
\newcommand{\numero}[1]{\def\@numero{#1}}
\newcommand{\group}[1]{\def\@group{#1}}
\newcommand{\teacher}[1]{\def\@teacher{#1}}
\newcommand{\location}[1]{\def\@location{#1}}

\RequirePackage{xifthen}
\NewDocumentCommand{\ifequals}{m m m o}{\ifthenelse{\equal{#1}{#2}}{#3}{\IfValueT{#4}{#4}}}
\newcommand{\case}[2]{#1 #2}
\newenvironment{switch}[1]{\renewcommand{\case}{\ifequals{#1}}}{}

\usepackage{enumitem}
\setlist[itemize]{noitemsep, topsep=-\parskip}
\def\labelitemi{---}
\setlist[enumerate]{noitemsep, topsep=-\parskip}

\RequirePackage{csquotes}
\RequirePackage{caption}
\captionsetup[figure]{name=\makeinttext{Figure}{Малюнак}{Рисунок}, labelsep=endash}

\renewcommand{\maketitle}{
    \begin{titlepage}
        \centering
        \makeinttext{Educational institution}{Установа адукацыі}{Учреждение образования}\\
        [\the\baselineskip]
        \textquote{\makeinttext{Belarusian State University of Informatics and Radio Electronics}{Беларускі дзяржаўны ўніверсітэт інфарматыкі і радыёэлектронікі}{Белорусский государственный университет\\информатики и радиоэлектроники}}\\
        [\the\baselineskip]
        \@departament\\
        [\dimexpr\the\baselineskip * 7]
        \begin{switch}{\@worktype}
            \case{lab}{\makeinttext{Report on laboratory work}{Справаздача па лабараторнай рабоце}{Отчет по лабораторной работе}~\textnumero\@numero}
            \case{practice}{\makeinttext{Report on practical work}{Справаздача па практычнай рабоце}{Отчет по практической работе}~\textnumero\@numero}
            \case{essay}{\makeinttext{Essay on the topic}{Эсэ па тэме}{Эссэ по теме}}
        \end{switch}\\
        \textbf{\textquote{\@title}}\\
        [\dimexpr\the\baselineskip * 10]
        \raggedleft
        \parbox[right]{7cm}{\@author\\\@group\\\@teacher}
        \vfill
        \centering
        \@location~\@date
    \end{titlepage}
}

\newcommand{\makepar}[2]{\textbf{\textit{#1:}} #2}
\newcommand{\makegoal}[1]{\makepar{\makeinttext{Goal}{Мэта}{Цель}}{#1}}
\newcommand{\makesummary}[1]{\makepar{\makeinttext{Summary}{Выснова}{Вывод}}{#1}}
\newcommand{\makevariant}[2]{\makepar{\makeinttext{Option}{Варыянт}{Вариант}~\textnumero #1}{#2}}

\NewDocumentCommand{\makefilelisting}{m m o}{
    \begin{figure}[H]
        \centering
        \inputminted[curlyquotes, texcomments, breaklines, fontsize=\small]{#2}{#1}
        \IfValueT{#3}{\caption{\ifequals{#3}{\\FILENAME}{#1}[#3]}}
        \label{fig:#1}
    \end{figure}
}

\NewDocumentCommand{\makeimage}{m o}{
    \begin{figure}[H]
        \centering
        \includegraphics[width=\textwidth]{#1}
        \caption{\IfValueTF{#2}{#2}{#1}}
        \label{fig:#1}
    \end{figure}
}

\NewDocumentCommand{\makescheme}{m o}{
    \begin{figure}[H]
        \centering
        \includesvg{#1}
        \caption{\IfValueTF{#2}{#2}{#1}}
        \label{fig:#1}
    \end{figure}
}

\NewDocumentEnvironment{problem}{m m o}{
    \titleformat{\section}{\large}{\makeinttext{Problem}{Заданне}{Задание} \textnumero\thesection~}{0em}{}
    \section{\IfValueT{#3}{\textquote{#3}}}
    \makevariant{#1}{#2}
}{}
