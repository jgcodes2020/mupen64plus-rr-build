__sp :=
__sp +=
inter = .inter.$(subst $(__sp),_,$(subst /,_,$1))

ATOMIC=\
    $(eval s1=$(strip $1)) \
    $(eval target=$(call inter,$(s1))) \
    $(eval $(s1): $(target) ;) \
    $(eval .INTERMEDIATE: $(target) ) \
    $(target)