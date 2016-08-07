# export PATH="$HOME/perl5/bin${PATH:+:${PATH}}"
# export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
# export PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
# export PERL_MB_OPT="--install_base \"$HOME/perl5\""
# export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
# export PERL_CPANM_OPT="--local-lib=~/local/lib/perl5"
# export PERL5LIB=$HOME/local/lib/perl5/lib/perl5:$PERL5LIB;

if which plenv > /dev/null; then eval "$(plenv init -)"; fi
alias ce="carton exec"
