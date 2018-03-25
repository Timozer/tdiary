% !TEX TS-program xelatex
% !TEX encoding = UTF-8 Unicode
% -*- coding: UTF-8; -*-
% vim: set fenc=utf-8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  FileName: tdiary.cls
%%  Author:   Timozer
%%  E-mail:   zhenyuwang94@gmail.com
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{tdiary}[2018/03/23 Version 0.1 Timozer Personal Journal LaTeX Template for Daily Life Record and Research Diary]

%\newif\ifcug@doctor\cug@doctorfalse

%\DeclareOption{doctor}{\cug@doctortrue\cug@masterfalse\cug@masterprofulltimefalse\cug@masterpronofulltimefalse}
%\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}} % I don't want you to pass options to the ctexbook class
\ProcessOptions\relax

\LoadClass[ scheme=chinese, heading=true, %nofonts,
    10pt, utf8, a5paper, punct, fancyhdr, twoside, openany,
    amstex]{ctexbook}

%%%%%%%%%%%%%%%%%%%%%%% Load Packages %%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{xcolor, xifthen, xparse, xstring, fancyhdr, etoolbox}
\RequirePackage{niceframe}
\RequirePackage{amstext, amsmath, amssymb, amsfonts}
\RequirePackage{mathrsfs, bm, mathtools}

\RequirePackage{graphicx, tikz, pgfplots}
\RequirePackage[labelformat=simple]{subcaption}

\RequirePackage{array, longtable, makecell, tabu, booktabs}

\RequirePackage{enumitem} % 修改列表样式

%%%%%%%%%%%%%%%%%%% My own packages %%%%%%%%%%%%%%%%%%%%
\RequirePackage{tfonts}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------- Page Layout ---------------
\RequirePackage[a5paper, 
    marginparwidth=0pt, marginparsep=0pt,
    top=3cm, bottom=3cm, left=3cm, right=3cm, 
    headheight=2.5cm, headsep=10pt, footskip=2cm]{geometry}
%-------------------------封面制作---------------------------

\def\tdiary@define@term#1{
    \expandafter\gdef\csname #1\endcsname##1{%
        \expandafter\gdef\csname tdiary@#1\endcsname{##1}
    }
    \csname #1\endcsname{}
}

\RequirePackage{zhnumber}

\renewcommand{\maketitle}{}
\NewDocumentCommand{\tdiary@maketitle}{}{%
    \begin{titlepage}
        \thispagestyle{empty}
        \begin{center}
            \leavevmode 
            \vspace*{\baselineskip}
            {\Huge %\fontsize{75}{60}\selectfont
            \artdecoframe{\itshape Who\\ am \\ I}}
            \vspace*{2\baselineskip}
            \vfill
            {\large \emph{Timozer}}
            \vspace*{\baselineskip}
        \end{center}
    \end{titlepage}
}

\NewDocumentCommand{\tdiary@makeinfo}{}{%
    观点：现代人要了解自己比过去难的多，现在是一个信息爆炸的时代，人类大脑已不足以靠文字
    描述和回忆来认知自我。我们所接触的信息、观点、事物，已经让人陷入思维的迷宫，必须用
    简洁的标注法来寻找自我

    用坐标和符号的形式，记录生活轨迹，帮助自我定位。

    记录：心态、行为、思想

    目的：通过记录自己的心态、行为、思想，从而达到自我分析，自我了解的目的。
    找出源头，来解决目前陷入困境的原因，从而自我突破。
    分析细节，及时调整自我状态。

    原因：心态影响行为，行为影响思想，思想也影响心态、影响行为。

    心态：影响情绪的事（正面、负面）。起因，发生过程，结果（处理的如何），现在的想法，标签（情绪标签）。
    如实描述：本我，自我，超我；本我：不动脑子的本能；自我：动脑子的理性；超我：被约束的道德观。

    行为：今天做了什么（日常行为，下意识行为）

    思想：今天思考了什么（价值观、人生观、世界观）。价值观：个人对事物的判断；人生观：个人根据现实做出的
    判断；世界观：事物对世界的作用。人生观就是丢掉原则的价值观，价值观就是不考虑现实的人生观，世界观
    就是没有个人倾向的价值观。
}

\tdiary@define@term{date@year}
\tdiary@define@term{date@month}
\tdiary@define@term{date@day}

\newif\iftdiary@date@newyear\tdiary@date@newyearfalse

\NewDocumentCommand{\tyear}{m}{%
    \date@year{#1}
    \tdiary@date@newyeartrue % set the new year

    \cleardoublepage
    \thispagestyle{empty}
    \begin{tikzpicture}[scale=1, remember picture, overlay]
        \draw (current page.east) ++(-5cm, 1ex) node[anchor=south east, align=right]{%
                {\textit{\tfonts@chuhao \bfseries Year}}
            };

        \draw[black, very thick] (current page.west) ++(5cm, 0cm) -- (current page.east);
        \draw (current page.east) ++(-5cm, -1ex) node[anchor=north east, align=left]{%
                {\textit{\tfonts@chuhao \bfseries \tdiary@date@year}}
            };
    \end{tikzpicture}
    \clearpage 
    \thispagestyle{empty}
}

\NewDocumentCommand{\tmonth}{m}{%
    \date@month{#1}
    %\date@month{\expandafter#1}

    \iftdiary@date@newyear
        \cleardoublepage 
        \tdiary@date@newyearfalse
    \else
        \clearpage
    \fi
    
    \thispagestyle{tdiary@pagestyle@month}

    \vskip 2\baselineskip 
    \ifthenelse{\isodd{\thepage}}
    {
        % odd page  flushright
        \hfill \textit{\bfseries \tfonts@erhao \tdiary@date@month{}}
    }{%
        % even page flushleft
        \textit{\bfseries \tfonts@erhao \tdiary@date@month{}} \hfill 
    }
    \vskip 0.5\baselineskip 
    \par\noindent\rule[0.5ex]{\textwidth}{1pt}\par
    \vskip 0.5\baselineskip 
}
\NewDocumentCommand{\tday}{m}{%
    \date@day{#1}
    \vskip \baselineskip 
    \ifthenelse{\isodd{\thepage}}
    {
        % odd page flushright 
        \hfill \textit{\bfseries \tfonts@sanhao \tdiary@date@day}
    }{%
        % even page flushleft
        \textit{\bfseries \tfonts@sanhao \tdiary@date@day} \hfill 
    }
    \vskip \baselineskip 
}

% Disable the part, chapter, section, subsection, subsubsection cmds
\renewcommand{\part}{}
\renewcommand{\chapter}{}
\renewcommand{\section}{}
\renewcommand{\subsection}{}
\renewcommand{\subsubsection}{}
% Disable the tableofcontents, listoffigures, listoftables cmds
\renewcommand{\tableofcontents}{}
\renewcommand{\listoftables}{}
\renewcommand{\listoffigures}{}
%\renewcommand\arraystretch{1} % 将行距还原

%\newcounter{cug@authorcv@section}
%\newcommand{\cugauthorcvsection}[1]{%
    %\stepcounter{cug@authorcv@section}
    %{\par \sffamily\bfseries \noindent \chinese{cug@authorcv@section}、 #1}\par
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% insert web links 
\RequirePackage{url}
\expandafter\def\expandafter\UrlBreaks\expandafter{\UrlBreaks%  save the current one
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
    \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
      \do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D%
        \do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N%
          \do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X%
            \do\Y\do\Z\do\*\do\-\do\~\do\'\do\"\do\-}

\fancypagestyle{tdiary@pagestyle@default}{%
    \pagestyle{fancy}
    \fancyhf{}
    %\fancyhead[CO]{\small 中国地质大学\cug@@titlelogo}
    %\fancyhead[RO, LE]{\cug@wuhao \thepage}
    %\fancyhead[CE]{\cug@wuhao \@author: \@title}
    \fancyhead[CO, CE]{\textit{\tdiary@date@month{}.~\tdiary@date@day\ \tdiary@date@year}}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{0.4pt}
}
\fancypagestyle{tdiary@pagestyle@month}{%
    \pagestyle{fancy}
    \fancyhf{}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{0pt}
}
% Disable frontmatter, mainmatter, backmatter and appendix cmds
\renewcommand{\frontmatter}{}
\renewcommand{\mainmatter}{}
\renewcommand{\backmatter}{}
\renewcommand{\appendix}{}

\newcommand{\tdiary@frontmatter}{%
    \clearpage
    \pagestyle{empty}
}
\newcommand{\tdiary@mainmatter}{%
    \clearpage
    \pagenumbering{arabic}
    \pagestyle{tdiary@pagestyle@default}
}

\AtBeginDocument{%
    \tdiary@maketitle
    \tdiary@frontmatter
    \tdiary@makeinfo
    \tdiary@mainmatter 
}

\tdiary@define@term{tstartyear}
\tdiary@define@term{tthisyear}

\let\tforeach=\pgfplotsforeachungrouped 
\NewDocumentCommand{\treaddiaries}{}{%
    \tforeach \Year in {\tdiary@tstartyear,...,\tdiary@tthisyear}
    %\foreach \Year in {\tdiary@tstartyear,...,\tdiary@tthisyear}
    {   
        \IfFileExists{./diary/\Year/.folderexist}
        {
            \tyear{\Year}
            \tforeach \Month in {Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec}
            %\foreach \Month in {Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec}
            {   
                \IfFileExists{./diary/\Year/\Month/.folderexist}
                {
                    \tmonth{\Month}
                    \tforeach \Day in {1,...,31}
                    %\foreach \Day in {1,...,31}
                    {   
                        \IfFileExists{./diary/\Year/\Month/\Day}
                        {   
                            \tday{\Day}
                            \input{./diary/\Year/\Month/\Day}
                        }
                        {}   % files does not exist, so nothing to do
                    }
                }
                {} % if the month folder doesn't exist, nothing to do but continue next loop
            }
        }
        {} % if the year folder doesn't exist, nothing to do but continue next loop
    }
}

%%%%%%%%%%%%%%%%%%% 定制列表环境, 让它们看起来更紧凑一些 %%%%%%%%%%%%%%%%%%%%
\setlist[itemize]{parsep=0pt, itemsep=0pt, topsep=0pt, rightmargin=2em, partopsep=2pt}
\setlist[enumerate]{parsep=0pt, itemsep=0pt, topsep=0pt, rightmargin=2em, partopsep=2pt}
\setlist[description]{parsep=0pt, itemsep=0pt, topsep=0pt, rightmargin=2em, partopsep=2pt}
%%%%%%%%%%%%%%%%%%% The format of float's caption %%%%%%%%%%%%%%%%%%%%
%\RequirePackage{caption}
%\captionsetup{labelsep=quad, font={small, rm, singlespacing}, skip=10pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Logo
\NewDocumentCommand{\tdiary}{}{TDIARY}
%--------------- Source Code ---------------
\endinput 
