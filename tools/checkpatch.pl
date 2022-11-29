# Licensed under the terms of the GNU GPL License version 2
my $max_line_length = 80;
my $typedefsfile = "";
my $allow_c99_comments = 1;
  --max-line-length=n        set the maximum line length, if exceeded, warn
                             (default:/usr/share/codespell/dictionary.txt)
	my @types = ();
	for ($text =~ /(?:(?:\bCHK|\bWARN|\bERROR|&\{\$msg_level})\s*\(|\$msg_type\s*=)\s*"([^"]+)"/g) {
		push (@types, $_);
	@types = sort(uniq(@types));
	foreach my $type (@types) {
	'codespellfile=s'	=> \$codespellfile,
) or help(1);
help(0) if ($help);
	if (!$ignore_perl_version) {
		exit(1);
	}
if ($color =~ /^[01]$/) {
	$color = !$color;
} elsif ($color =~ /^always$/i) {
	$color = 1;
} elsif ($color =~ /^never$/i) {
	$color = 0;
} elsif ($color =~ /^auto$/i) {
	$color = (-t STDOUT);
} else {
	die "Invalid color mode: $color\n";
}
			__init_refok|
			__weak
our $String	= qr{"[X\t]*"};
			$$wordsRef .= '|' if ($$wordsRef ne "");
my $const_structs = "";
read_words(\$const_structs, $conststructsfile)
    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
my $typeOtherTypedefs = "";
if (length($typedefsfile)) {
$typeTypedefs .= '|' . $typeOtherTypedefs if ($typeOtherTypedefs ne "");
			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)?
			(?:(?:\s|\*|\[\])+\s*const|(?:\s|\*\s*(?:const\s*)?|\[\])+|(?:\s*\[\s*\])+)?
	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(|
	my $status = `perl $root/scripts/get_maintainer.pl --status --nom --nol --nogit --nogit-fallback -f $filename 2>&1`;
	return $status =~ /obsolete/i;
	if (-e ".git") {
		my $git_last_include_commit = `git log --no-merges --pretty=format:"%h%n" -1 -- include`;
	if (-e ".git") {
		$files = `git ls-files "include/*.h"`;
	return ($id, $desc) if ((which("git") eq "") || !(-e ".git"));
	my $output = `git log --no-color --format='%H %s' -1 $commit 2>&1`;
	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous\./) {
	} elsif ($lines[0] =~ /^fatal: ambiguous argument '$commit': unknown revision or path not in the working tree\./) {
die "$P: No git repository found\n" if ($git && !-e ".git");
		my $lines = `git log --no-color --no-merges --pretty=format:'%H %s' $git_range`;
	if ($^V lt 5.10.0) {
      An upgrade to at least perl v5.10.0 is suggested.
	$name = trim($name);
	$name =~ s/^\"|\"$//g;
	return ($name, $address, $comment);
	my ($name, $address) = @_;
	$name = trim($name);
	$name =~ s/^\"|\"$//g;
		$formatted_email = "$name <$address>";
	return $formatted_email;
			for (; ($n % 8) != 0; $n++) {
	my ($current_comment) = ($rawlines[$end_line - 1] =~ m@.*(/\*.*\*/)\s*(?:\\\s*)?$@);
	$output = (split('\n', $output))[0] . "\n" if ($terse);
	my $source_indent = 8;
			if ($1 =~ m@Documentation/admin-guide/kernel-parameters.rst$@) {
		    (($line =~ m@^\s+diff\b.*a/[\w/]+@ &&
		      $line =~ m@^\s+diff\b.*a/([\w/]+)\s+b/$1\b@) ||
		if ($line =~ /^\s*signed-off-by:/i) {
				WARN("BAD_SIGN_OFF",
				     "Non-standard signature: $sign_off\n" . $herecurr);
			my ($email_name, $email_address, $comment) = parse_email($email);
			my $suggested_email = format_email(($email_name, $email_address));
				if ("$dequoted$comment" ne $email &&
				    "<$email_address>$comment" ne $email &&
				    "$suggested_email$comment" ne $email) {
					     "email address '$email' might be better as '$suggested_email$comment'\n" . $herecurr);
# Check for old stable address
		if ($line =~ /^\s*cc:\s*.*<?\bstable\@kernel\.org\b>?.*$/i) {
			ERROR("STABLE_ADDRESS",
			      "The 'stable' address should be 'stable\@vger.kernel.org'\n" . $herecurr);
		}

# Check for unwanted Gerrit info
		if ($in_commit_log && $line =~ /^\s*change-id:/i) {
			ERROR("GERRIT_CHANGE_ID",
			      "Remove Gerrit Change-Id's before submitting upstream.\n" . $herecurr);
		     $line =~ /^\s*\[\<[0-9a-fA-F]{8,}\>\]/)) {
					# stack dump address
		      $line =~ /^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:/ ||
		      $line =~ /^\s*(?:Fixes:|Link:)/i ||
					# A Fixes: or Link: line
		if ($in_commit_log && !$commit_log_possible_stack_dump &&
		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&
		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
			my $hasdesc = 0;
			my $hasparens = 0;
			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
				$orig_desc = $1;
				$hasparens = 1;
			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
				 defined $rawlines[$linenr] &&
				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
				$orig_desc = $1;
				$hasparens = 1;
			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
				 defined $rawlines[$linenr] &&
				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
				$orig_desc = $1;
				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
				$orig_desc .= " " . $1;
				$hasparens = 1;
			}

			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
						  "'$typo' may be misspelled - perhaps '$typo_fix'?\n" . $herecurr) &&
			my $length = 0;
			my $cnt = $realcnt;
			my $ln = $linenr + 1;
			my $f;
			my $is_start = 0;
			my $is_end = 0;
			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
				$f = $lines[$ln - 1];
				$cnt-- if ($lines[$ln - 1] !~ /^-/);
				$is_end = $lines[$ln - 1] =~ /^\+/;
				last if (!$file && $f =~ /^\@\@/);

				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
					$is_start = 1;
				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
					if ($lines[$ln - 1] =~ "---help---") {
						WARN("CONFIG_DESCRIPTION",
						     "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
					}
					$length = -1;
				$f =~ s/^.//;
				$f =~ s/#.*//;
				$f =~ s/^\s+//;
				next if ($f =~ /^$/);
				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
						  if|endif|menu|endmenu|source)\b/x) {
					$is_end = 1;
				$length++;
			if ($is_start && $is_end && $length < $min_conf_desc_length) {
				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
# check for MAINTAINERS entries that don't have the right form
		if ($realfile =~ /^MAINTAINERS$/ &&
		    $rawline =~ /^\+[A-Z]:/ &&
		    $rawline !~ /^\+[A-Z]:\t\S/) {
			if (WARN("MAINTAINERS_STYLE",
				 "MAINTAINERS entries use one tab after TYPE:\n" . $herecurr) &&
			    $fix) {
				$fixed[$fixlinenr] =~ s/^(\+[A-Z]):\s*/$1:\t/;
# discourage the use of boolean for type definition attributes of Kconfig options
		if ($realfile =~ /Kconfig/ &&
		    $line =~ /^\+\s*\bboolean\b/) {
			WARN("CONFIG_TYPE_BOOLEAN",
			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
		}

			my $vp_file = $dt_path . "vendor-prefixes.txt";
				`grep -Eq "^$vendor\\b" $vp_file`;
				} elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc)$/) {
				    $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
				WARN($msg_type,
				     "line over $max_line_length characters\n" . $herecurr);
			WARN("MISSING_EOF_NEWLINE",
			     "adding a line without newline at end of file\n" . $herecurr);
# more than 8 must use tabs.
					   s/(^\+.*) {8,8}\t/$1\t\t/) {}
			CHK("ASSIGNMENT_CONTINUATIONS",
			    "Assignment operator '$1' should be on the previous line\n" . $hereprev);
			CHK("LOGICAL_CONTINUATIONS",
			    "Logical continuations should be on the previous line\n" . $hereprev);
		if ($^V && $^V ge 5.10.0 &&
			if ($indent % 8) {
					$fixed[$fixlinenr] =~ s@(^\+\t+) +@$1 . "\t" x ($indent/8)@e;
		if ($^V && $^V ge 5.10.0 &&
					"\t" x ($pos / 8) .
					" "  x ($pos % 8);
		    $realline > 2) {
		if ($sline =~ /^\+\s+\S/ &&			#Not at char 1
			# actual declarations
		    ($prevline =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
		     $prevline =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
		     $prevline =~ /^\+\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
		     $prevline =~ /^\+\s+$declaration_macros/) &&
		    !($prevline =~ /^\+\s+$c90_Keywords\b/ ||
		      $prevline =~ /(?:$Compare|$Assignment|$Operators)\s*$/ ||
		      $prevline =~ /(?:\{\s*|\\)$/) &&
		    !($sline =~ /^\+\s+$Declare\s*$Ident\s*[=,;:\[]/ ||
		      $sline =~ /^\+\s+$Declare\s*\(\s*\*\s*$Ident\s*\)\s*[=,;:\[\(]/ ||
		      $sline =~ /^\+\s+$Ident(?:\s+|\s*\*\s*)$Ident\s*[=,;\[]/ ||
		      $sline =~ /^\+\s+$declaration_macros/ ||
		      $sline =~ /^\+\s+(?:union|struct|enum|typedef)\b/ ||
		      $sline =~ /^\+\s+(?:$|[\{\}\.\#\"\?\:\(\[])/ ||
		      $sline =~ /^\+\s+$Ident\s*:\s*\d+\s*[,;]/ ||
		      $sline =~ /^\+\s+\(?\s*(?:$Compare|$Assignment|$Operators)/) &&
			# indentation of previous and current line are the same
		    (($prevline =~ /\+(\s+)\S/) && $sline =~ /^\+$1\S/)) {
			if (WARN("LINE_SPACING",
				 "Missing a blank line after declarations\n" . $hereprev) &&
			    $fix) {
				fix_insert_line($fixlinenr, "\+");
# if the previous line is a goto or return and is indented the same # of tabs
			if ($prevline =~ /^\+$tabs(?:goto|return)\b/) {
				WARN("UNNECESSARY_BREAK",
				     "break is not useful after a goto or return\n" . $hereprev);
			    (($sindent % 8) != 0 ||
			     ($sindent > $indent + 8))) {
		    ($lines[$realline_next - 1] =~ /EXPORT_SYMBOL.*\((.*)\)/ ||
		     $lines[$realline_next - 1] =~ /EXPORT_UNUSED_SYMBOL.*\((.*)\)/)) {
		    ($line =~ /EXPORT_SYMBOL.*\((.*)\)/ ||
		     $line =~ /EXPORT_UNUSED_SYMBOL.*\((.*)\)/)) {
		if ($line =~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=\s*($zero_initializer)\s*;/) {
               }
               }
               }
		if ($line =~ /(\b$Type\s+$Ident)\s*\(\s*\)/) {
		if ($line =~ /\bprintk\s*\(\s*KERN_([A-Z]+)/) {
			my $orig = $1;
			     "Prefer [subsystem eg: netdev]_$level2([subsystem]dev, ... then dev_$level2(dev, ... then pr_$level(...  to printk(KERN_$orig ...\n" . $herecurr);
		}

		if ($line =~ /\bpr_warning\s*\(/) {
			if (WARN("PREFER_PR_LEVEL",
				 "Prefer pr_warn(... to pr_warning(...\n" . $herecurr) &&
			    $fix) {
				$fixed[$fixlinenr] =~
				    s/\bpr_warning\b/pr_warn/;
			}
		if ($^V && $^V ge 5.10.0 &&
				$fixed_line =~ /(^..*$Type\s*$Ident\(.*\)\s*){(.*)$/;
					if ($ctx =~ /Wx./) {
					    	$ok = 1;
## 			# falsly report the parameters of functions.
		    $line =~ /do\{/) {
				$fixed[$fixlinenr] =~ s/^(\+.*(?:do|\)))\{/$1 {/;
		if ($line =~ /}(?!(?:,|;|\)))\S/) {
		    $^V && $^V ge 5.10.0 && defined($stat) &&
#goto labels aren't indented, allow a single space however
		if ($line=~/^.\s+[A-Za-z\d_]+:(?![0-9]+)/ and
		   !($line=~/^. [A-Za-z\d_]+:/) and !($line=~/^.\s+default:/)) {
			if ($^V && $^V ge 5.10.0 &&
               }
		if ($^V && $^V ge 5.10.0 &&
		if ($^V && $^V ge 5.10.0 &&
			if ($name ne 'EOF' && $name ne 'ERROR') {
				ERROR("ASSIGN_IN_IF",
				      "do not use assignment in if condition\n" . $herecurr);
			$s =~ s/$;//g; 	# Remove any comments
			$s =~ s/$;//g; 	# Remove any comments
#gcc binary extension
			if ($var =~ /^$Binary$/) {
				if (WARN("GCC_BINARY_CONSTANT",
					 "Avoid gcc v4.3+ binary constant extension: <$var>\n" . $herecurr) &&
				    $fix) {
					my $hexval = sprintf("0x%x", oct($var));
					$fixed[$fixlinenr] =~
					    s/\b$var\b/$hexval/;
				}
			}

#Ignore SI style variants like nS, mV and dB (ie: max_uV, regulator_min_uA_show)
			    $var !~ /^(?:[a-z_]*?)_?[a-z][A-Z](?:_[a-z_]+)?$/ &&
			while ($dstat =~ s/\([^\(\)]*\)/1/ ||
			       $dstat =~ s/\{[^\{\}]*\}/1/ ||
			       $dstat =~ s/.\[[^\[\]]*\]/1/)
			# Flatten any obvious string concatentation.
				$tmp_stmt =~ s/\b(typeof|__typeof__|__builtin\w+|typecheck\s*\(\s*$Type\s*,|\#+)\s*\(*\s*$arg\s*\)*\b//g;
		if ($^V && $^V ge 5.10.0 &&
# make sure symbols are always wrapped with VMLINUX_SYMBOL() ...
# all assignments may have only one of the following with an assignment:
#	.
#	ALIGN(...)
#	VMLINUX_SYMBOL(...)
		if ($realfile eq 'vmlinux.lds.h' && $line =~ /(?:(?:^|\s)$Ident\s*=|=\s*$Ident(?:\s|$))/) {
			WARN("MISSING_VMLINUX_SYMBOL",
			     "vmlinux.lds.h needs VMLINUX_SYMBOL() around C-visible symbols\n" . $herecurr);
		}

		if ($line =~ /$String[A-Z_]/ || $line =~ /[A-Za-z0-9_]$String/) {
			CHK("CONCATENATED_STRING",
			    "Concatenated strings should use spaces between elements\n" . $herecurr);
		if ($line =~ /$String\s*"/) {
			WARN("STRING_FRAGMENTS",
			     "Consecutive strings are generally better as a single string\n" . $herecurr);
			CHK("REDUNDANT_CODE",
			    "if this code is redundant consider removing it\n" .
				$herecurr);
			if ($s =~ /(?:^|\n)[ \+]\s*(?:$Type\s*)?\Q$testval\E\s*=\s*(?:\([^\)]*\)\s*)?\s*(?:devm_)?(?:[kv][czm]alloc(?:_node|_array)?\b|kstrdup|kmemdup|(?:dev_)?alloc_skb)/) {
		if ($^V && $^V ge 5.10.0 &&
		if ($^V && $^V ge 5.10.0) {
				    "usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt\n" . $herecurr);
				     "msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt\n" . $herecurr);
			wmb|
			read_barrier_depends
# check for smp_read_barrier_depends and read_barrier_depends
		if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
			WARN("READ_BARRIER_DEPENDS",
			     "$1read_barrier_depends should only be used in READ_ONCE or DEC Alpha code\n" . $herecurr);
# Check for __attribute__ packed, prefer __packed
		    $line =~ /\b__attribute__\s*\(\s*\(.*\bpacked\b/) {
			WARN("PREFER_PACKED",
			     "__packed is preferred over __attribute__((packed))\n" . $herecurr);
		}

# Check for __attribute__ aligned, prefer __aligned
		if ($realfile !~ m@\binclude/uapi/@ &&
		    $line =~ /\b__attribute__\s*\(\s*\(.*aligned/) {
			WARN("PREFER_ALIGNED",
			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
		}

# Check for __attribute__ format(printf, prefer __printf
		if ($realfile !~ m@\binclude/uapi/@ &&
		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf/) {
			if (WARN("PREFER_PRINTF",
				 "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
			    $fix) {
				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;

		}
# Check for __attribute__ format(scanf, prefer __scanf
		if ($realfile !~ m@\binclude/uapi/@ &&
		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\b/) {
			if (WARN("PREFER_SCANF",
				 "__scanf(string-index, first-to-check) is preferred over __attribute__((format(scanf, string-index, first-to-check)))\n" . $herecurr) &&
			    $fix) {
				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*scanf\s*,\s*(.*)\)\s*\)\s*\)/"__scanf(" . trim($1) . ")"/ex;
		if ($^V && $^V ge 5.10.0 &&
				 "Unnecessary typecast of c90 int constant\n" . $herecurr) &&
				my $suffix = "";
				my $newconst = $const;
				$newconst =~ s/${Int_type}$//;
				$suffix .= 'U' if ($cast =~ /\bunsigned\b/);
				if ($cast =~ /\blong\s+long\b/) {
					$suffix .= 'LL';
				} elsif ($cast =~ /\blong\b/) {
					$suffix .= 'L';
				}
		if ($^V && $^V ge 5.10.0 &&
			my $specifier;
			my $extension;
			my $bad_specifier = "";
				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOx]/) {
						$ext_type = "Deprecated";
		if ($^V && $^V ge 5.10.0 &&
#		if ($^V && $^V ge 5.10.0 &&
#		if ($^V && $^V ge 5.10.0 &&
#		if ($^V && $^V ge 5.10.0 &&
		if ($^V && $^V ge 5.10.0 &&
		if ($^V && $^V ge 5.10.0 &&
				     "usleep_range should not use min == max args; see Documentation/timers/timers-howto.txt\n" . "$here\n$stat\n");
				     "usleep_range args reversed, use min then max; see Documentation/timers/timers-howto.txt\n" . "$here\n$stat\n");
		if ($^V && $^V ge 5.10.0 &&
		if ($^V && $^V ge 5.10.0 &&
			if ($s =~ /^\s*;/ &&
			    $function_name ne 'uninitialized_var')
		if ($^V && $^V ge 5.10.0 &&
				    "__setup appears un-documented -- check Documentation/admin-guide/kernel-parameters.rst\n" . $herecurr);
# check for pointless casting of kmalloc return
		if ($line =~ /\*\s*\)\s*[kv][czm]alloc(_node){0,1}\b/) {
		if ($^V && $^V ge 5.10.0 &&
		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*([kv][mz]alloc(?:_node)?)\s*\(\s*(sizeof\s*\(\s*struct\s+$Lval\s*\))/) {
		if ($^V && $^V ge 5.10.0 &&
		if ($^V && $^V ge 5.10.0 &&
		    $line =~ /\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*krealloc\s*\(\s*\1\s*,/) {
		if ($line =~ /\b(kcalloc|kmalloc_array)\s*\(\s*sizeof\b/) {
		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
				 "Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE\n" . $herecurr) &&
# check for case / default statements not preceded by break/fallthrough/switch
		if ($line =~ /^.\s*(?:case\s+(?:$Ident|$Constant)\s*|default):/) {
			my $has_break = 0;
			my $has_statement = 0;
			my $count = 0;
			my $prevline = $linenr;
			while ($prevline > 1 && ($file || $count < 3) && !$has_break) {
				$prevline--;
				my $rline = $rawlines[$prevline - 1];
				my $fline = $lines[$prevline - 1];
				last if ($fline =~ /^\@\@/);
				next if ($fline =~ /^\-/);
				next if ($fline =~ /^.(?:\s*(?:case\s+(?:$Ident|$Constant)[\s$;]*|default):[\s$;]*)*$/);
				$has_break = 1 if ($rline =~ /fall[\s_-]*(through|thru)/i);
				next if ($fline =~ /^.[\s$;]*$/);
				$has_statement = 1;
				$count++;
				$has_break = 1 if ($fline =~ /\bswitch\b|\b(?:break\s*;[\s$;]*$|exit\s*\(\b|return\b|goto\b|continue\b)/);
			}
			if (!$has_break && $has_statement) {
				WARN("MISSING_BREAK",
				     "Possible switch case/default not preceded by break or fallthrough comment\n" . $herecurr);
		if ($^V && $^V ge 5.10.0 &&
# check for bool bitfields
		if ($sline =~ /^.\s+bool\s*$Ident\s*:\s*\d+\s*;/) {
			WARN("BOOL_BITFIELD",
			     "Avoid using bool as bitfield.  Prefer bool bitfields as unsigned int or u<8|16|32>\n" . $herecurr);
		}

		if ($line !~ /\bconst\b/ &&
		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/)
		if ($^V && $^V ge 5.10.0 &&
# check for mutex_trylock_recursive usage
		if ($line =~ /mutex_trylock_recursive/) {
			ERROR("LOCKING",
			      "recursive locking is bad, do not use this ever.\n" . $herecurr);
		}

		if ($^V && $^V ge 5.10.0 &&
		if ($^V && $^V ge 5.10.0 &&
	# This is not a patch, and we are are in 'no-patch' mode so
	if ($is_patch && $has_commit_log && $chk_signoff && $signoff == 0) {
		ERROR("MISSING_SIGN_OFF",
		      "Missing Signed-off-by: line(s)\n");