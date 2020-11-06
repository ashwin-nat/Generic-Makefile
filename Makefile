###############################################################
# General purpose variables. Set COMPILER = $(CXX) for C++,   #
#                                COMPILER = $(CC) for C       #
###############################################################
RM_RF		= rm -rf
MKDIR_P		= mkdir -p
SRCEXT		= c
HDREXT		= h
OBJEXT		= o
COMPILER	= $(CC)

###############################################################
# Variables for compile and link time flags                   #
###############################################################
CFLAGS		= -Wall -Werror -c
CFLAGS_SAN	= -fsanitize=address -fsanitize=undefined
CFLAGS_DBG	= -O0 -ggdb3
CFLAGS_REL	= -O2

LDFLAGS		=
LDFLAGS_DBG	=
LDFLAGS_SAN	= -lasan -lubsan
LDFLAGS_REL	=

###############################################################
# Variables for directories (Please don't suffix them with /) #
###############################################################
SRCDIR		= src
HDRDIR		= inc
OBJDIR		= obj
EXECDIR		= bin

###############################################################
# The final variable for the binary name                      #
###############################################################
BINARY		= $(EXECDIR)/main

###############################################################
# List variables                                              #
###############################################################
OBJTREE_TMP	= $(addprefix $(OBJDIR)/,\
				$(subst $(SRCDIR)/,,$(SRCTREE)))

HDRLIST		= $(addprefix -I , $(shell find $(HDRDIR) -type d))
SRCLIST		= $(shell find $(SRCDIR) -name "*.$(SRCEXT)")
OBJLIST		= $(subst .$(SRCEXT),.$(OBJEXT),\
				$(subst $(SRCDIR)/,$(OBJDIR)/,$(SRCLIST)))
SRCTREE		= $(shell find $(SRCDIR) -type d)
OBJTREE		= $(subst $(SRCDIR),,$(OBJTREE_TMP))

###############################################################
# Please don't modify anything below this line                #
###############################################################
.PHONY:		all release clean dir_check debug_print \
				cflags_rel debugsan debug
all: release

###############################################################
# In case you want to see the file lists generated            #
###############################################################
debug_print:
	@echo "HDRLIST = $(HDRLIST)"
	@echo "SRCLIST = $(SRCLIST)"
	@echo "OBJLIST = $(OBJTREE)"
	@echo "SRCTREE = $(SRCTREE)"
	@echo "OBJTREE = $(OBJTREE)"

###############################################################
# Create directory structure if required                      #
###############################################################
dir_check:
	@$(MKDIR_P) $(OBJDIR)
	@$(MKDIR_P) $(EXECDIR)
	@$(MKDIR_P) $(OBJTREE)

###############################################################
# Release build - add extra CFLAGS and LDFLAGS                #
###############################################################
release: CFLAGS+=$(CFLAGS_REL)
release: LDFLAGS+=$(LDFLAGS_REL)
release: dir_check $(BINARY)

###############################################################
# Debug build (without runtime sanitizers)                    #
###############################################################
debug: CFLAGS+=$(CFLAGS_DBG)
debug: LDFLAGS+=$(LDFLAGS_DBG)
debug: dir_check $(BINARY)

###############################################################
# Debug build (with Address and UB runtime sanitizers)        #
###############################################################
debugsan: CFLAGS+=$(CFLAGS_DBG)
debugsan: CFLAGS+=$(CFLAGS_SAN)
debugsan: LDFLAGS+=$(LDFLAGS_DBG)
debugsan: LDFLAGS+=$(LDFLAGS_SAN)
debugsan: dir_check $(BINARY)

###############################################################
# Compile all source files with CFLAGS                        #
###############################################################
$(OBJDIR)/%.$(OBJEXT):$(SRCDIR)/%.$(SRCEXT)
	$(COMPILER) $(CFLAGS) $(HDRLIST) -o $@ $<

###############################################################
# Link all object files with LDFLAGS                          #
###############################################################
$(BINARY): $(OBJLIST)
	$(COMPILER) $(LDFLAGS) $(OBJLIST) -o $(BINARY)

###############################################################
# Remove all created directories and subdirectories           #
###############################################################
clean:
	$(RM_RF) $(OBJDIR)
	$(RM_RF) $(EXECDIR)

###############################################################
# Help output                                                 #
###############################################################
help:
	@echo "make               ----> Builds in release mode"
	@echo "make release       ----> Builds in release mode"
	@echo "make debug         ----> Builds in debug mode (without sanitizers)"
	@echo "make debugsan      ----> Builds in debug mode (with address and UB sanitizers)"
	@echo "make clean         ----> Deletes the $(HDRDIR)/ and $(OBJDIR)/ directories"
	@echo "make debug_print   ----> Prints the file lists that are generated by this Makefile"