# dot-emacs
This repo holds my dot-emacs files.
It's not an exact copy of my real `.emacs.d/` content, but rather a minimal version.
I decided to uploat it as it could be useful to anybody that wants to use Emacs with EXWM as its main driver, 
hoping it wil save the new users a little time.

## Perequisites
If you want to use just Emacs and EXWM (no Gnome-Flashback session) you just need to install
`use-package`.

Alternative browse the code to find the tools required to install (OS installation) depending on your needs. 

## About my setup
Some time ago I bought a fantastic [Ergodox EZ](https://ergodox-ez.com/).
As my typing speed improved, I felt unsatisfied by the constant loss of time due to the mouse interaction.
So, I decided to minimize it moving to a different Window Manager.
If you use Emacs what can be better than [EXWM](https://github.com/ch11ng/exwm)?
EXWM allows you fully control your X applications inside Emacs, as if they were just buffers.

As I use Emacs as my main driver, I'm happy.
However there are situations in which you just want the job to be done quickly, leaving the troubleshooting 
(and the fun) for later.
In this case it could be useful to rely on a GNOME-Flashback session, and 
[EXWM-Gnome-Flashback](https://github.com/WJCFerguson/exwm-gnome-flashback) is what you need.

It is comfortable to have the same setup everywhere, especially if you have many devices.
In this repo you can find a pragmatic way to manage different hosts and multi-monitor setups.

I try to keep the structure of my dot-emacs clean and simple.
Load time is not too important to me, as Emacs init happens only once a day.
To keep my init files compact I use [use-package](https://github.com/jwiegley/use-package).
It also manages to automatically install and setup all the packages when I use Emacs on a new PC.

I recommend trying Emacs + EXWM, it is a very satisfying experience.
There is no need to be confortable with Elisp to be productive.

Many thanks to [ch11ng](https://github.com/ch11ng) and to the other EXWM and XELB contributors to make them possible.

### Bonus tip
You may want to start using EXWM but for practical reasons keep using your IDE, for example Intellij IDEA, 
especially if you work on very big multi-language projects.
If you experience some strange issue and you may think EXWM is not rendering the X application properly, 
try setting `export _JAVA_AWT_WM_NONREPARENTING=1` in your `XSession` (this is not due to EXWM). 
