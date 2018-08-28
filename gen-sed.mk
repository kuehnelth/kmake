extra-gen   += sed

define sed_rule
cleanfiles += $(OUTDIR)$(1)

$(OUTDIR)$(1): SED_SCRIPT = $(call getvar,$(1),SED_SCRIPT)
$(OUTDIR)$(1): CMD = $$(SED_SCRIPT)
$(OUTDIR)$(1): $(SRCDIR)$(call getsrc,$(1))
$(OUTDIR)$(1): $(OUTDIR)$(call getcmdfile,$(1))
endef

define sed_recipe
%.c: %.c.sed
	$$(call printcmd,GEN,$$@)
	$$(Q)sed -e $$(SED_SCRIPT) $$< >$$@.tmp && mv $$@.tmp $$@
endef

sed-suffix := c.sed

.SUFFIXES: c.sed