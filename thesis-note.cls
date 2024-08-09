\NeedsTeXFormat{LaTeX2e}
% Originally based on my homework-math class.
\ProvidesClass{thesis-note}

%%% DEFAULTS %%%
\def\@true{1}
\def\@false{0}
\def\ifempty#1{\def\temp{#1} \ifx\temp\empty}

\def\@subtitle{}
\def\@contact{}
\def\@author{}
\def\@title{}
\def\@titlecolor{black}%

\newcommand\@hmgeometry\@true
\newcommand\@hmcountbyexercises\@false
\newcommand\@hmonlymacros\@false
\newcommand\@hmtypewriter\@false
\newcommand\@tnnoplex\@false
\newcommand\@tndatetime\@true

\newcommand\@hmtinyfont{cmbxsl10}
\newcommand\@hmlargefont{cmbxsl22}
\newcommand\@hmsmallfont{cmbxsl14}

\font\japanese=dmjhira
%%% OPTIONS %%%

\DeclareOption{iPad}{%
	\renewcommand\@hmlargefont{cmbxsl10 at 22pt}
	\renewcommand\@hmsmallfont{cmbxsl10 at 14pt}
}%

\DeclareOption{nogeometry}{%
	\renewcommand\@hmgeometry\@false
}%

\DeclareOption{countbysections}{%
	\renewcommand\@hmcountbyexercises\@false
}%

\DeclareOption{onlymacros}{%
	\renewcommand\@hmonlymacros\@true
}%

\DeclareOption{typewriter}{%
	\renewcommand\@hmtypewriter\@true
}%

\DeclareOption{defaultdate}{%
  \renewcommand\@tndatetime\@false
}%

\DeclareOption{noplex}{%
    \renewcommand\@tnnoplex\@true
}%

\ProcessOptions\relax
\if\@hmtypewriter\@false
	\LoadClass{article}%
\else
	\LoadClass[ms]{memoir}%
	\setlrmarginsandblock{1in}{1in}{*}%
	\setulmarginsandblock{1in}{*}{1}%
	\checkandfixthelayout%
	\chapterstyle{dash}%
\fi

%%% DEPENDENCIES %%%
\RequirePackage{fancyhdr}
\RequirePackage{etoolbox}% 
\RequirePackage{graphicx}
\RequirePackage{scalerel}
\RequirePackage{tikz,tikz-cd,tikz-3dplot}
\usetikzlibrary{%
  shapes, arrows, calc, positioning, shapes.geometric,%
  decorations.pathreplacing, decorations.markings, mindmap,%
	decorations, patterns, decorations.pathmorphing%
}%
\RequirePackage{mathtools}
\RequirePackage{amsthm,amsmath,amssymb}
\RequirePackage{gensymb}
\RequirePackage{stmaryrd}
\RequirePackage{faktor}
\RequirePackage{stackengine}
\RequirePackage{hyperref}
\RequirePackage[shortcuts]{extdash}
\RequirePackage{setspace}
\RequirePackage{xcolor}
\RequirePackage{tcolorbox}
% Add this package to count the number of exercises in the document.
\RequirePackage{totcount}
\RequirePackage{tocloft}

% For code inside document
\RequirePackage{listings}
\lstdefinelanguage{Lambda}{%
  morekeywords={%
    if,then,else,fix,let,in
  },% keywords
  morekeywords={[2]int,a,b,sigma},% types
  otherkeywords={:}, % operators
  literate={% string to symbols
    {->}{{$\to$}}{2}
    {=>}{{$\Rightarrow$}}{2}
    {~>}{{$\tendsto$}}{2}
    {lambda}{{$\lambda$}}{1}
    {mu}{{$\mu$}}{1}
  },%
  basicstyle={\ttfamily},%
  keywordstyle={\bfseries},%
  keywordstyle={[2]\itshape},%
  keepspaces,
  mathescape% enable math mode
}[keywords,comments,strings]%
\lstMakeShortInline[language=Lambda]|

\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{ltblue}{rgb}{0,0.4,0.4}
\definecolor{dkviolet}{rgb}{0.3,0,0.5}

% lstlisting coq style (inspired from a file of Assia Mahboubi)
\lstdefinelanguage{Coq}{ 
    % Anything betweeen $ becomes LaTeX math mode
    mathescape=true,
    % Comments may or not include Latex commands
    texcl=false, 
    % Vernacular commands
    morekeywords=[1]{Section, Module, End, Require, Import, Export,
        Variable, Variables, Parameter, Parameters, Axiom, Hypothesis,
        Hypotheses, Notation, Local, Tactic, Reserved, Scope, Open, Close,
        Bind, Delimit, Definition, Let, Ltac, Fixpoint, CoFixpoint, Add,
        Morphism, Relation, Implicit, Arguments, Unset, Contextual,
        Strict, Prenex, Implicits, Inductive, CoInductive, Record,
        Structure, Canonical, Coercion, Context, Class, Global, Instance,
        Program, Infix, Theorem, Lemma, Corollary, Proposition, Fact,
        Remark, Example, Proof, Goal, Save, Qed, Defined, Hint, Resolve,
        Rewrite, View, Search, Show, Print, Printing, All, Eval, Check,
        Projections, inside, outside, Def},
    % Gallina
    morekeywords=[2]{forall, exists, exists2, fun, fix, cofix, struct,
        match, with, end, as, in, return, let, if, is, then, else, for, of,
        nosimpl, when},
    % Sorts
    morekeywords=[3]{Type, Prop, Set, true, false, option},
    % Various tactics, some are std Coq subsumed by ssr, for the manual purpose
    morekeywords=[4]{pose, set, move, case, elim, apply, clear, hnf,
        intro, intros, generalize, rename, pattern, after, destruct,
        induction, using, refine, inversion, injection, rewrite, congr,
        unlock, compute, ring, field, fourier, replace, fold, unfold,
        change, cutrewrite, simpl, have, suff, wlog, suffices, without,
        loss, nat_norm, assert, cut, trivial, revert, bool_congr, nat_congr,
        symmetry, transitivity, auto, split, left, right, autorewrite},
    % Terminators
    morekeywords=[5]{by, done, exact, reflexivity, tauto, romega, omega,
        assumption, solve, contradiction, discriminate},
    % Control
    morekeywords=[6]{do, last, first, try, idtac, repeat},
    % Comments delimiters, we do turn this off for the manual
    morecomment=[s]{(*}{*)},
    % Spaces are not displayed as a special character
    showstringspaces=false,
    % String delimiters
    morestring=[b]",
    morestring=[d]’,
    % Size of tabulations
    tabsize=3,
    % Enables ASCII chars 128 to 255
    extendedchars=false,
    % Case sensitivity
    sensitive=true,
    % Automatic breaking of long lines
    breaklines=false,
    % Default style fors listings
    basicstyle=\small,
    % Position of captions is bottom
    captionpos=b,
    % flexible columns
    columns=[l]flexible,
    % Style for (listings') identifiers
    identifierstyle={\ttfamily\color{black}},
    % Style for declaration keywords
    keywordstyle=[1]{\ttfamily\color{dkviolet}},
    % Style for gallina keywords
    keywordstyle=[2]{\ttfamily\color{dkgreen}},
    % Style for sorts keywords
    keywordstyle=[3]{\ttfamily\color{ltblue}},
    % Style for tactics keywords
    keywordstyle=[4]{\ttfamily\color{dkblue}},
    % Style for terminators keywords
    keywordstyle=[5]{\ttfamily\color{dkred}},
    %Style for iterators
    %keywordstyle=[6]{\ttfamily\color{dkpink}},
    % Style for strings
    stringstyle=\ttfamily,
    % Style for comments
    commentstyle={\ttfamily\color{dkgreen}},
    %moredelim=**[is][\ttfamily\color{red}]{/&}{&/},
    literate=
    {\\forall}{{\color{dkgreen}{$\forall\;$}}}1
    {\\exists}{{$\exists\;$}}1
    {<-}{{$\leftarrow\;$}}1
    {=>}{{$\Rightarrow\;$}}1
    {==}{{\code{==}\;}}1
    {==>}{{\code{==>}\;}}1
    %    {:>}{{\code{:>}\;}}1
    {->}{{$\rightarrow\;$}}1
    {<->}{{$\leftrightarrow\;$}}1
    {<==}{{$\leq\;$}}1
    {\#}{{$^\star$}}1 
    {\\o}{{$\circ\;$}}1 
    {\@}{{$\cdot$}}1 
    {\/\\}{{$\wedge\;$}}1
    {\\\/}{{$\vee\;$}}1
    {++}{{\code{++}}}1
    {~}{{$\sim$}}1
    {\@\@}{{$@$}}1
    {\\mapsto}{{$\mapsto\;$}}1
    {\\hline}{{\rule{\linewidth}{0.5pt}}}1
    {lambda}{{$\lambda$}}1
    {mu}{{$\mu$}}1
    %
}[keywords,comments,strings]

% Make pretty titles
\RequirePackage{soul}
\RequirePackage[explicit]{titlesec}

\if\@tnnoplex\@false
    \RequirePackage{plex-serif}
    \RequirePackage{plex-sans}
    \RequirePackage{plex-mono}
    \renewcommand\@hmtinyfont{IBMPlexSans-BoldItalic-tlf-ot1 at 10pt}
    \renewcommand\@hmlargefont{IBMPlexSans-BoldItalic-tlf-ot1 at 22pt}
    \renewcommand\@hmsmallfont{IBMPlexSans-BoldItalic-tlf-ot1 at 14pt}
\fi

\if\@tndatetime\@true
  \RequirePackage[long,nodayofweek,24hr]{datetime}
\fi

\if\@hmtypewriter\@true
	\renewcommand{\headrulewidth}{0pt}%
	\RequirePackage{memhfixc}%
\fi

%%% Any page modifications for DEPENDENCIES go here
\if\@hmonlymacros\@false
	\if\@hmgeometry\@true
		\RequirePackage[margin=1in]{geometry}%
	\fi
\fi

%%% FONTS %%%

\font\tinyslbf=\@hmtinyfont
\font\tenslbf=\@hmlargefont
\font\smallslbf=\@hmsmallfont

%%% Any page modifications for FONTS go here
\if\@hmonlymacros\@false
	\renewcommand{\normalsize}{\fontsize{10}{12}\selectfont}
\fi

%%% DOCUMENT SETUP %%%

%% Setup

\if\@hmonlymacros\@false
	\if\@hmtypewriter\@false
		\onehalfspacing%
		\setlength{\cftbeforesecskip}{1pt}%
	\else
		\OnehalfSpacing%
	\fi
\fi

\definecolor{IlliniBlue}{RGB}{19,41,75}
\definecolor{UrbanaOrange}{RGB}{232,74,39}
\definecolor{UIUCTeal}{RGB}{13,96,94}
\definecolor{UIUCGray-blue}{RGB}{111,175,199}
\definecolor{UIUCCitron}{RGB}{191,212,109}
\definecolor{UIUCDark-yellow}{RGB}{255,209,37}
\definecolor{UIUCSalmon}{RGB}{238,94,94}
\definecolor{UIUCPeriwinkle}{RGB}{79,104,152}
\definecolor{ThesisSage}{RGB}{127,160,110}

\gdef\@titlecolor{ThesisSage}

\newcounter{exctr}
\setcounter{exctr}{0}
\regtotcounter{exctr}
\renewcommand\theexctr{\arabic{exctr}}%

\newcounter{sectionrulechecker}
\newcommand{\nosectionrule}{\setcounter{sectionrulechecker}{1}}
\setcounter{sectionrulechecker}{0}

\newcounter{specialboxctr}
\setcounter{specialboxctr}{0}

\newbox\@tnTitleUnderlineBox
\newcommand*\@tnTitleUnderline[1]{%
  \bgroup
  \setbox\@tnTitleUnderlineBox\hbox{\colorbox{\@titlecolor}\strut}%
  \setul{\dimexpr\dp\@tnTitleUnderlineBox-.15ex\relax}{.15ex}%
  \ul{\mbox{#1}}%
  \egroup%
}%
\providecommand\tnTitleUnderline[1]{\@tnTitleUnderline{#1}}
\newcommand*\@tnSectionNumberBox[1]{%
  \colorbox{\@titlecolor}
  {%
    \makebox[1.5em][c]{%
      \color{white}%
      \strut%
      \csname the#1\endcsname
    }%
  }%
  \@tnTitleUnderline{\ \ \ }%
}%
\newcommand*\@tnBareNumberBox[1]{%
  \colorbox{\@titlecolor}
  {%
    \makebox[1.5em][c]{%
      \color{white}%
      \strut%
      \csname the#1\endcsname
    }%
  }%
  {\ \ \ }%
}%

\if\@hmonlymacros\@false
  \if\@hmtypewriter\@false
    \titleformat{\section}%
    {\large\bfseries\sffamily\color{\@titlecolor}}%
    {\@tnSectionNumberBox{section}}%
    {0pt}%
    {\@tnTitleUnderline{#1}}%
    \titleformat{\subsection}%
    {\normalsize\bfseries\sffamily\color{\@titlecolor}}%
    {\@tnBareNumberBox{subsection}}
    {0pt}
    {{#1}}
    \titleformat{\subsubsection}%
    {\normalsize\bfseries\sffamily}%
    {\@tnBareNumberBox{subsubsection}}%
    {0pt}%
    {{#1}}%
  \fi
\fi



%%% Any page modifications for DOCUMENT SETUP.setup go here
% tikz magic from:
% https://tex.stackexchange.com/questions/39296/simulating-hand-drawn-lines
\pgfset{%
	/pgf/decoration/randomness/.initial=5,%
	/pgf/decoration/wavelength/.initial=100%
}%
\pgfdeclaredecoration{sketch}{init}{%
	\state{init}[width=0pt,next state=draw,persistent precomputation={%
		\pgfmathsetmacro\pgf@lib@dec@sketch@t0%
	}]{}%
	\state{draw}[width=\pgfdecorationsegmentlength,%
	auto corner on length=\pgfdecorationsegmentlength,%
	persistent precomputation={%
		\pgfmathsetmacro\pgf@lib@dec@sketch@t{mod(\pgf@lib@dec@sketch@t+pow(\pgfkeysvalueof{/pgf/decoration/randomness},rand),\pgfkeysvalueof{/pgf/decoration/wavelength})}%
	}]{%
		\pgfmathparse{sin(2*\pgf@lib@dec@sketch@t*pi/\pgfkeysvalueof{/pgf/decoration/wavelength} r)}%
		\pgfpathlineto{\pgfqpoint{\pgfdecorationsegmentlength}{\pgfmathresult\pgfdecorationsegmentamplitude}}%
	}%
	\state{final}{}%
}%
\tikzset{%
	xkcd/.style={decorate,decoration={sketch,segment length=0.5pt,amplitude=0.5pt}}%
}%
\tikzset{%
	xkcdto/.style={decorate,decoration{sketch,segment%
	length=0.5pt,amplitude=0.5pt,mark=at position 0.5 with {\arrow{to}}}}%
}%
\pgfmathsetseed{1}%
% End tikz magic

\if\@hmtypewriter\@true
	\tikzcdset{%
		arrows=xkcd%
	}%
\fi

\if\@hmonlymacros\@false
	\if\@hmcountbyexercises\@true
		\renewcommand\theequation{\theexctr.\arabic{equation}}%
		\renewcommand\thespecialboxctr{\arabic{exctr}.\arabic{specialboxctr}}%
	\else
		\renewcommand\theequation{\thesection.\arabic{equation}}%
		\renewcommand\thespecialboxctr{\thesection.\arabic{specialboxctr}}%
	\fi

	% header commands are called at the end to give a chance for the user to load
	% the geometry package, which must be loaded before headers are defined
	\if\@hmtypewriter\@false
		\AtEndPreamble{%
			\pagestyle{fancy}%
			\rhead{\textit\@subtitle}%
			\lhead{\textit\@title}%
			\cfoot{\thepage}%
		}%
	\else
		\AtEndPreamble{%
			\pagestyle{fancy}%
			\rhead{\@subtitle}%
			\lhead{\@title}%
			\cfoot{\thepage}%
			\RequirePackage[upright]{fourier}%
			\RequirePackage[frenchmath,italic,nosmalldelims]{mathastext}%
			\raggedright%
			\renewcommand{\thesection}{\arabic{section}}
		}%
	\fi
\fi

%% Document methods %%

\if\@hmtypewriter\@true
	\def\hmtypewritertableofcontents{%
		\begingroup%
		\setlength{\beforechapskip}{0pt}
		\tableofcontents*%
		\endgroup%
	}%
\fi

\def\subtitle#1{\gdef\@subtitle{#1}}
\def\contact#1{\gdef\@contact{#1}}
\def\titlecolor#1{\gdef\@titlecolor{#1}}%
\def\leftheader#1{\gdef\@leftheader{#1}}%
\def\rightheader#1{\gdef\@rightheader{#1}}%
\edef\measurepage{\dimexpr\pagegoal-\pagetotal-\baselineskip\relax}

\providecommand{\smalltableofcontents}{%
	\if\@hmtypewriter\@false\singlespacing\else\SingleSpacing\fi%
	\centerline{%
		\begin{minipage}[c]{0.65\linewidth}%
			\small
			\if\@hmtypewriter\@true\hmtypewritertableofcontents\else\tableofcontents\fi%
		\end{minipage}%
		\if\@hmtypewriter\@false\onehalfspacing\else\OnehalfSpacing\fi%
	}%
}%

\providecommand{\makehmtitle}{{%
  \thispagestyle{plain} % surpress header on first page
  \color{\@titlecolor}%
  {\noindent{\tenslbf{\@title}}}
  \quad
  {\smallslbf{\@subtitle}}
  \hfill{\color{darkgray}\large\textit\@author}
  \smallskip
  \linebreak%\hrule
  \smallskip
  {%
	  {\color{darkgray}\noindent\textit{\@date}\hfill\textit{\@contact}}
  }%
  \bigbreak
}}%

\newcommand{\makecenteredtitle}{{%
	\thispagestyle{plain}%
	\color{\@titlecolor}%
	{\hspace*{\fill}\smallslbf{\@title}\hspace*{\fill}}
	\smallskip
	\hrule
	\smallskip
	{%
		{%
			\color{darkgray}%
			\noindent\textit{\@subtitle}%
			\hfill%
			\textit{\@author~(\@contact)}%
			\hfill%
			\textit{\@date}%
		}%
	}%
	\bigbreak
}}%


% Maintain compatibility with typewriter-math
\newcommand\makehomeworktitle{%
	\thispagestyle{empty}%
        {\noindent\tenslbf\@title}%
        \ifx\@subtitle\empty\else\\{\smallslbf\@subtitle}\fi
        \smallskip
        \ifx\@author\empty\else\\{\color{darkgray}\@author}\fi
        \ifx\@contact\empty\else\\{\color{darkgray}\@contact}\fi
        \smallskip
        \ifx\@date\empty\else\\{\color{gray}\tinyslbf\@date}\fi
}%

\if\@hmonlymacros\@false
	\if\@hmtypewriter\@false
		\renewcommand\maketitle{\makehmtitle}%
	\else
		\renewcommand\maketitle{\makehomeworktitle}%
	\fi
\fi

%%% FORMATTING METHODS %%%

% Section delimiter using circular dots.
\providecommand{\dhorline}[3][0]{%
    \tikz[baseline]{\path[decoration={markings,
      mark=between positions 0 and 1 step 2*#3
      with {\node[fill, circle, minimum width=#3, inner sep=0pt, anchor=south west] {};}},postaction={decorate}]  (0,#1) -- ++(#2,0);}}
	
\if\@hmtypewriter\@true
	\def\sectionrule{%
		\fancybreak{* * * * *}%
	}%
\else
	\def\sectionrule{%
		\par%
		\vskip \baselineskip%
		\cleaders\vbox{\noindent\hspace*{\fill}\mbox{\dhorline{5em}{3pt}}\hspace*{\fill}}%
		\vskip 0.5em%
		\nointerlineskip %
		\vskip \baselineskip%
	}%
\fi

\newenvironment{indented}{%
  \par%
  \medskip
  \leftskip=4em\rightskip=2em%
  \noindent\ignorespaces}{%
  \par\medskip
}

\if\@hmtypewriter\@true
	\renewcommand\qedsymbol{\tikz{%
		\node[xkcd,draw,fill=black] (b) at (0,0) {};%
	}}%
\fi

%%% ABBREVIATIONS %%%
% For SNL
\DeclareMathOperator\True{{\mathsf{True}}}
\DeclareMathOperator\False{{\mathsf{False}}}
\DeclareMathOperator\K{{\mathsf{K}}}
\DeclareMathOperator\LLP{LLP}
\DeclareMathOperator\RLP{RLP}
\DeclareMathOperator\Cell{Cell}
\DeclareMathOperator\leftsf{\mathsf{left}}
\DeclareMathOperator\rightsf{\mathsf{right}}
\DeclareMathOperator\return{\mathsf{return}}
\DeclareMathOperator\bind{\mathsf{bind}}
\DeclareMathOperator\Cyl{Cyl}
\DeclareMathOperator\List{\mathsf{List}}
\DeclareMathOperator\Coeq{Coeq}
\newcommand\X{{\mathscr{X}}}
\newcommand\calS{{\mathcal{S}}}
\newcommand\calE{{\mathcal{E}}}
\newcommand\shiftscript[1]{{\mkern-3.5mu {#1}}}
\newcommand\xvdash[1]{\mathrel{%
        \stackengine{0.4ex}{\vdash\;}{\;\;\scriptscriptstyle#1}{U}{c}{F}{T}{L}}}
\stackMath
\newcommand\nf[1]{{{#1}\kern-.3em-\kern-.3em\mathsf{nf}}}
\newcommand\scrW{{\mathscr{W}}}
\newcommand\scrC{{\mathscr{C}}}
\newcommand\scrF{{\mathscr{F}}}
\newcommand\scrE{{\mathscr{E}}}
\newcommand\scrJ{{\mathscr{J}}}
\newcommand\scrM{{\mathscr{M}}}
\providecommand\xleadsto[1]{{\overset{{#1}}{\leadsto}}}
\newcommand\Cl{{\mathcal{C}\kern-.15em\ell}}
\providecommand{\fbb}[1]{{\left\llbracket{#1}\right\rrbracket}}
\providecommand\dpwrap[1]{{\left(\kern-.15em\left({#1}\right)\kern-.15em\right)}}
\DeclareMathOperator\Lan{Lan}
\newcommand\Nat{{\mathsf{Nat}}}
\newcommand\Set{{\mathsf{Set}}}
\newcommand\Th{{\mathsf{Th}}}
\newcommand\F{{\mathbb{F}}}
\newcommand\ulK{{\ul{K}}}
\newcommand\Karr{{\overrightarrow{K}}}
\newcommand\pwarg[2][]{{%
        \ifx&#1&%
                % #2 is empty
                {\ensuremath{#2}}%
        \else%
                % #2 is nonempty
                {\ensuremath{#2}^{\pwrap{#1}}}%
        \fi%
}}%
\newcommand\One{\mathds{1}}

% For declaring objects in a category (in a Haskell-like manner)
\providecommand{\catin}{\mathrel{::}}

\providecommand{\ul}[1]{\underline{#1}}
\providecommand{\hw}[1]{\widehat{#1}}
\providecommand{\bvec}[1]{\overrightarrow{#1}}

% Groupings macros.
\providecommand{\fb}[1]{{\left[#1\right]}}
\providecommand{\pwrap}[1]{{\left(#1\right)}}
\providecommand{\bwrap}[1]{{\left\{#1\right\}}}
\providecommand{\abs}[1]{{\left\vert#1\right\vert}}
\providecommand{\norm}[1]{{\left\|#1\right\|}}
\providecommand{\brak}[1]{{\left\langle#1\right\rangle}}

\if\@hmtypewriter\@true
  \providecommand\restr[2]{{#1}\mid{#2}}
\else
  \providecommand\restr[2]{{% we make the whole thing an ordinary symbol
    \left.\kern-\nulldelimiterspace% automatically resize the bar with \right
      #1% the function
      \vphantom{\big\vert }% pretend it's a little taller at normal size
    \right\vert_{#2} % this is the delimiter
  }}
\fi

\providecommand{\eqdef}{\overset{\normalfont{\text{def}}}{=}}
\providecommand{\equivdef}{\overset{\normalfont{\text{def}}}{\equiv}}

\renewcommand{\leq}{\leqslant}
\renewcommand{\geq}{\geqslant}

% fg for "function group"
\providecommand{\fg}[2]{{#2}^{\scalebox{0.75}{#1}}}
\providecommand{\minisub}[2]{#1_{\scalebox{0.65}{#2}}}
\providecommand{\id}{\mathsf{id}}

\DeclareMathOperator{\Dom}{Dom}
\DeclareMathOperator{\dom}{dom}
\DeclareMathOperator{\Range}{Range}
\DeclareMathOperator{\Hom}{\normalfont{\text{Hom}}}
\DeclareMathOperator{\Sub}{\normalfont{\text{Sub}}}

\DeclareMathOperator\Yo{\text{\normalfont\japanese \char"48}}
\DeclareMathOperator\coYo{\rotatebox[origin=c]{180}{\(\Yo\)}}

%% For adding special characters from other fonts
%% https://tex.stackexchange.com/a/247819
\DeclareFontFamily{U}{BOONDOX-calo}{\skewchar\font=45}
\DeclareFontShape{U}{BOONDOX-calo}{m}{n}{
  <-> s*[1.05] BOONDOX-r-calo}{}
\DeclareFontShape{U}{BOONDOX-calo}{b}{n}{
  <-> s*[1.05] BOONDOX-b-calo}{}
\DeclareMathAlphabet{\mathbdc}{U}{BOONDOX-calo}{m}{n}
\SetMathAlphabet{\mathbdc}{bold}{U}{BOONDOX-calo}{b}{n}
\DeclareMathAlphabet{\mathbbdc}{U}{BOONDOX-calo}{b}{n}
\DeclareSymbolFont{BOONDOX-calo}{U}{BOONDOX-calo}{m}{n}
\DeclareMathSymbol{\pcal}{\mathalpha}{BOONDOX-calo}{112}

\providecommand{\expo}[1]{{%
  \text{\normalfont{exp}}\left(#1\right)%
}}%

\providecommand{\interior}[1]{{#1\degree}}
\providecommand{\closure}[1]{{\lbar{#1}}}

\DeclareRobustCommand{\actson}{\mathrel{\rotatebox[origin=c]{90}{\(\curvearrowleft\)}}}

\providecommand{\ep}{\varepsilon}
\providecommand{\R}{\mathbb{R}}
\providecommand{\N}{\mathbb{N}}
\providecommand{\Q}{\mathbb{Q}}
\providecommand{\C}{\mathbb{C}}
\providecommand{\Z}{\mathbb{Z}}
\providecommand\op{{\mathsf{op}}}

% Based on
% https://davidyat.es/2016/07/27/writing-a-latex-macro-that-takes-a-variable-number-of-arguments/
\newcommand\cycle[1]{%
	\begin{psmallmatrix}%
		#1\@cyclechecknextarg}
\newcommand{\@cyclechecknextarg}{\@ifnextchar\bgroup{\@cyclegobblenextarg}{%
	\end{psmallmatrix} }}
\newcommand{\@cyclegobblenextarg}[1]{ & #1 \@ifnextchar\bgroup{\@cyclegobblenextarg}{%
	\end{psmallmatrix} }}

\def\comment#1{{\color{magenta} [#1]}}

\newenvironment{exercise}[1][]{%
\refstepcounter{exctr}%
\setcounter{sectionrulechecker}{0}
\label{ex:\theexctr}%
\addcontentsline{toc}{section}{Exercise \theexctr~#1}%
\noindent\textbf{Exercise \theexctr~#1:~}%
}%
{%
	\ifnum\theexctr<\totvalue{exctr} %
		\ifnum\value{sectionrulechecker}<1 %
			\sectionrule
		\fi%
	\fi%
}%

\newenvironment{exercise*}{%
\noindent\textbf{Exercise:}%
}%
{%
\sectionrule
}%

\newenvironment{exercise-like}[2][Exercise]{%
	\refstepcounter{exctr}%
	\setcounter{sectionrulechecker}{0}
	\label{ex:\theexctr}%
	\addcontentsline{toc}{section}{Exercise \theexctr~#2}%
	\noindent\textbf{#1 \theexctr~#2:~}%
}%
{%
	\ifnum\theexctr<\totvalue{exctr} %
		\ifnum\value{sectionrulechecker}<1 %
			\sectionrule
		\fi%
	\fi%
}%

\newenvironment{centered-exercise-like}[3][Exercise]{%
	\refstepcounter{exctr}%
	\setcounter{sectionrulechecker}{0}
	\label{ex:\theexctr}%
	\addcontentsline{toc}{section}{#1 \theexctr~#2}%
	\def\temp{#2}\ifx\temp\empty
		\begin{center}%
				\fontsize{11}{11}\selectfont%
				\textbf{#1 \theexctr}%
		\end{center}%
	\else
		\begin{center}%
			\fontsize{11}{11}\selectfont%
			\textbf{#1 \theexctr:~#2}%
		\end{center}%
	\fi
	\nobreak
	#3
	\par
	\medskip
}%
{%
	\ifnum\theexctr<\totvalue{exctr} %
		\ifnum\value{sectionrulechecker}<1 %
			\sectionrule
		\fi%
	\fi%
}%

\newenvironment{last_exercise}[1][]{%
\refstepcounter{exctr}%
\label{ex:\theexctr}%
\addcontentsline{toc}{section}{Exercise \theexctr~#1}%
\noindent\textbf{Exercise \theexctr~#1:~}%
}%
{%
\par\vspace{\baselineskip}
}%
\newenvironment{last_exercise*}{%
\noindent\textbf{Exercise:}%
}%
{%
\par\vspace{\baselineskip}
}%

% Box macros.

\providecommand\boxhrule{\tcblower}%

\newenvironment{colored_box}[2][\@titlecolor]{%
  \refstepcounter{specialboxctr}%
  \begin{tcolorbox}[title={#2 \thespecialboxctr}, colframe=#1]
  }%
  {%
  \end{tcolorbox}%
}%

\newenvironment{colored_box*}[1][\@titlecolor]{%
  \begin{tcolorbox}[colframe=#1]%
  }%
  {%
  \end{tcolorbox}%
}%

\newenvironment{comment_box}[1][Comment]{%
  \begin{colored_box}[magenta]{#1}%
  }%
  {%
  \end{colored_box}%
}%

\newenvironment{comment_box*}{%
  \begin{colored_box*}[magenta]%
  }%
  {%
  \end{colored_box*}%
}%

\if\@hmtypewriter\@false
  \newenvironment{warning_box}[1]{%
    \begin{colored_box}{#1}%
    }%
    {%
    \end{colored_box}%
  }%
  \newenvironment{warning_box*}{%
    \begin{colored_box*}%
    }%
    {%
    \end{colored_box*}%
  }%
\else
  \newenvironment{warning_box}[1]{%
    \fancybreak{***}%
    \textbf{#1}%
    \begin{indented}%
    }%
    {%
    \end{indented}%
    \fancybreak{***}%
  }%
  \newenvironment{warning_box*}{%
    \fancybreak{***}%
    \begin{indented}%
    }%
    {%
    \end{indented}%
    \fancybreak{***}%
  }%
\fi

% New theorem-like environments
% These will be typeset in italics
\if\@hmcountbyexercises\@true
  \newtheorem{theorem}{Theorem}[exctr]%
\else
  \newtheorem{theorem}{Theorem}[section]%
\fi

\newtheorem{metatheorem}[theorem]{Metatheorem}
\newtheorem*{metatheorem*}{Metatheorem}
\newtheorem*{theorem*}{Theorem}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem*{proposition*}{Proposition}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem*{lemma*}{Lemma}
\newtheorem{claim}[theorem]{Claim}
\newtheorem*{claim*}{Claim}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem*{corollary*}{Corollary}
\newtheorem{remark}[theorem]{Remark}
\newtheorem*{remark*}{Remark}
\newtheorem{question}[theorem]{Question}
\newtheorem*{question*}{Question}
\newtheorem{researchquestion}[theorem]{Further Research}
\newtheorem*{researchquestion*}{Further Research}
\newtheorem{mathrule}[theorem]{Rule}
\newtheorem{ansatz}[theorem]{Ansatz}
\newtheorem*{ansatz*}{Ansatz}
\newtheorem{observation}[theorem]{Observation}
\newtheorem*{observation*}{Observation}

% These will be typeset in Roman
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem*{definition*}{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem*{example*}{Example}
\newtheorem{fact}[theorem]{Fact}
\newtheorem{conjecture}[theorem]{Conjecture}
\newtheorem*{conjecture*}{Conjecture}
\newtheorem{definitionprop}[theorem]{Definition/Proposition}
\newtheorem*{definitionprop*}{Definition/Proposition}
\newtheorem{bigremark}[theorem]{Remark}
\newtheorem*{bigremark*}{Remark}


% Silly things
\def\TLiPoS{%
    \normalfont%
    TL
    \kern-.35em
    {%
        \sbox\z@ A%
        \vbox to\ht\z@ {%
            \hbox{% start a horizontal box
                \check@mathfonts%
                \fontsize\sf@size\z@%
                \math@fontsfalse%
                \selectfont%
                I
            }%
            \vss%
        }%
    }%
    \kern-.30em%
    P
    \kern-.46em%
    o
    \kern-.36em%
    S
}

% Modifications to make certain macros look funnier in typewriter mode.
\def\xkcdto{\scalerel*{\begin{tikzpicture}%
	\draw[xkcd,->] (0,0) -- (0.5,0);%
\end{tikzpicture}}{-}}%
\def\xkcdleftarrow{\scalerel*{\begin{tikzpicture}%
	\draw[xkcd,<-] (0,0) -- (0.5,0);%
\end{tikzpicture}}{-}}%
\def\xkcdmapsto{\scalerel*{\begin{tikzpicture}%
	\draw[xkcd,|->] (0,0) -- (0.5,0);%
\end{tikzpicture}}{-}}%
\if\@hmtypewriter\@true
	\renewcommand\to{\xkcdto}
	\renewcommand\leftarrow{\xkcdleftarrow}
	\renewcommand\mapsto{\xkcdmapsto}
	\renewcommand\in{\mathrel{\,\varepsilon\,}}
	\renewcommand\notin{\mathrel{\,\!\not\mathrel{\,\varepsilon\!}\,\,}}
\fi
