Þ    O        k         ¸  ú   ¹  ,   ´  5   á  N     7   f  \     _   û  `   [	  u   ¼	  b   2
  V   
     ì
  %   |     ¢     ¹  5   Ó  B   	     L  w   i     á     ø          1  $   I     n               ¬     µ  #   Ô     ø               .     @     R  H   _     ¨     Â  !   á               -     @  #   ^            $   ¼     á        #     2   >     q           ¦     Ä  *   ã  *        9     Y     i  #   w  #     &   ¿     æ     õ  ,        A     Z  -   o          ¬     »     Ñ     ç     õ          '  Ü  B  û     0     -   L  G   z  <   Â  ^   ÿ  Z   ^  ]   ¹  o     [     K   ã  j   /  '        Â     Û  2   ú  >   -     l  {                   8     Q  !   n          ©     Å     Õ     å          #     9     @     S     q       T   ¤     ù       /   -     ]     q          ¦     Â     Þ  #   ö  )         D     e       $        Ä  2   à          -  1   L  )   ~     ¨     Ä     Ñ  #   ß  #      "   '      J   !   ]   (         ¨      ¿      ×      õ      	!     !     7!     N!     b!     |!  !   !                     '              L       4                           6   /       5           7   N   H   *   <            0                 @         1       %   2   
          &   (       ;   -          !                    B          $             +   =       3   D   K           E      .   8   	       ,   F   O   A      )   C   >   M   J      9      :       G   "   I       #       ?            
If no -e, --expression, -f, or --file option is given, then the first
non-option argument is taken as the sed script to interpret.  All
remaining arguments are names of input files; if no input files are
specified, then the standard input is read.

       --help     display this help and exit
       --version  output version information and exit
   --follow-symlinks
                 follow symlinks when processing in place
   --posix
                 disable all GNU extensions.
   -R, --regexp-perl
                 use Perl 5's regular expressions syntax in the script.
   -b, --binary
                 open files in binary mode (CR+LFs are not processed specially)
   -e script, --expression=script
                 add the script to the commands to be executed
   -f script-file, --file=script-file
                 add the contents of script-file to the commands to be executed
   -l N, --line-length=N
                 specify the desired line-wrap length for the `l' command
   -n, --quiet, --silent
                 suppress automatic printing of pattern space
   -u, --unbuffered
                 load minimal amounts of data from the input files and flush
                 the output buffers more often
 %s: -e expression #%lu, char %lu: %s
 %s: can't read %s: %s
 %s: file %s line %lu: %s
 %s: warning: failed to get security context of %s: %s %s: warning: failed to set default file creation context to %s: %s : doesn't want any addresses GNU sed home page: <http://www.gnu.org/software/sed/>.
General help using GNU software: <http://www.gnu.org/gethelp/>.
 Invalid back reference Invalid character class name Invalid collation character Invalid content of \{\} Invalid preceding regular expression Invalid range end Invalid regular expression Memory exhausted No match No previous regular expression Premature end of regular expression Regular expression too big Success Trailing backslash Unmatched ( or \( Unmatched ) or \) Unmatched \{ Usage: %s [OPTION]... {script-only-if-no-other-script} [input-file]...

 `e' command not supported `}' doesn't want any addresses can't find label for jump to `%s' cannot remove %s: %s cannot rename %s: %s cannot stat %s: %s command only uses one address comments don't accept any addresses couldn't attach to %s: %s couldn't edit %s: is a terminal couldn't edit %s: not a regular file couldn't follow symlink %s: %s couldn't open file %s: %s couldn't open temporary file %s: %s delimiter character is not a single-byte character error in subprocess expected \ after `a', `c' or `i' expected newer version of sed extra characters after command invalid reference \%d on `s' command's RHS invalid usage of +N or ~N as first address invalid usage of line address 0 missing command multiple `!'s multiple `g' options to `s' command multiple `p' options to `s' command multiple number options to `s' command no input files no previous regular expression number option to `s' command may not be zero option `e' not supported read error on %s: %s strings for `y' command are different lengths unexpected `,' unexpected `}' unknown command: `%c' unknown option to `s' unmatched `{' unterminated `s' command unterminated `y' command unterminated address regex Project-Id-Version: sed 4.2.1
Report-Msgid-Bugs-To: bug-gnu-utils@gnu.org
POT-Creation-Date: 2017-02-03 17:17-0800
PO-Revision-Date: 2013-02-12 23:37+0800
Last-Translator: Wei-Lun Chao <bluebat@member.fsf.org>
Language-Team: Chinese (traditional) <zh-l10n@linux.org.tw>
Language: zh_TW
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Bugs: Report translation errors to the Language-Team address.
Plural-Forms: nplurals=1; plural=0;
 
å¦ææªè¨­å® -e, --expression, -f, æ --file é¸é ï¼é£éº¼ç¬¬ä¸åä¸æ¯é¸é ç
å¼æ¸å°±æè¢«ç¶å sed çå½ä»¤ç¨¿ä¾è§£è­¯ãææå©ä¸çå¼æ¸åæ¯è¼¸å¥æªçåç¨±ï¼
åå¦æªæå®è¼¸å¥æªï¼å°±æå¾æ¨æºè¼¸å¥ä¾è®åã

       --help     é¡¯ç¤ºæ¬è¼å©è¨æ¯ä¸¦é¢é
       --version  è¼¸åºçæ¬è³è¨ä¸¦é¢é
   --follow-symlinks
                 å°±å°èçæè¿½é¨ç¬¦èé£çµ
   --posix
                 åç¨ææ GNU æ´ååè½ã
   -R, --regexp-perl
                 å¨å½ä»¤ç¨¿ä¸­ä½¿ç¨ Perl 5 çæ­£è¦è¡¨ç¤ºå¼èªæ³ã
   -b, --binary
                 ä»¥äºé²ä½æ¨¡å¼éåæªæ¡ (ä¸¦æªç¹æ®èç CR+LF)
   -e å½ä»¤ç¨¿, --expression=å½ä»¤ç¨¿
                 å å¥å½ä»¤ç¨¿åçºå·è¡çå½ä»¤
   -f å½ä»¤ç¨¿æªæ¡, --file=å½ä»¤ç¨¿æªæ¡
                 å å¥å½ä»¤ç¨¿æªæ¡å§å®¹åçºå·è¡çå½ä»¤
   -l N, --line-length=N
                 æå®ä½¿ç¨ãlãå½ä»¤ææ³è¦çæåé·åº¦
   -n, --quiet, --silent
                 ææ­¢æ¨£çç©ºéçèªåé¡¯ç¤º
   -u, --unbuffered
                 å¾è¼¸å¥æªä¸­è®åæå°éçè³æä¸¦æ´å¸¸æ¸ç©ºè¼¸åºç·©è¡å
 %s: -e è¡¨ç¤ºå¼ #%luï¼å­å %lu: %s
 %s: ç¡æ³è®å %s: %s
 %s: æªæ¡ %s åè: %lu: %s
 %sï¼è­¦åï¼ç¡æ³æå %sï¼%s çå®å¨èªå¢ %sï¼è­¦åï¼ç¡æ³è¨­å® %sï¼%s çé è¨­æªæ¡å»ºç«èªå¢ : ä¸éè¦ä»»ä½ä½å GNU sed é¦é ï¼<http://www.gnu.org/software/sed/>ã
ä½¿ç¨ GNU è»é«çä¸è¬èªªæï¼<http://www.gnu.org/gethelp/>ã
 ä¸æ­£ç¢ºçè¿ååè ä¸æ­£ç¢ºçå­åç­ç´åç¨± ä¸æ­£ç¢ºçæ ¸å°å­å ä¸æ­£ç¢ºçã\{\}ãå§å®¹ ä¸æ­£ç¢ºçåå°æ­£è¦è¡¨ç¤ºå¼ ä¸æ­£ç¢ºçç¯åçµæ ä¸æ­£ç¢ºçæ­£è¦è¡¨ç¤ºå¼ è¨æ¶é«èç¡ æ²æç¬¦åè æ²æååçæ­£è¦è¡¨ç¤ºå¼ æ­£è¦è¡¨ç¤ºå¼çéæ©çµæ æ­£è¦è¡¨ç¤ºå¼å¤ªå¤§ æå æ«ç«¯æåæç· æªå¹éçã(ãæã\ã æªå¹éçã)ãæã\ã æªå¹éçã\{ã ç¨æ³: %s [é¸é ]... {è¥ç¡å¶ä»å½ä»¤ç¨¿ååªè½æ¾å½ä»¤ç¨¿} [è¼¸å¥æª]...

 ä¸æ¯æ´å½ä»¤ãeã ã}ãä¸éè¦ä»»ä½ä½å ç¡æ³çºç®çæ¯ã%sãçè·³ç§»æ¾å°æ¨ç±¤ ç¡æ³ç§»é¤ %s: %s ç¡æ³æ´æ¹åç¨± %s: %s ç¡æ³åå¾çæ %sï¼%s å½ä»¤åªä½¿ç¨ä¸åä½å åè¨»ä¸æ¥åä»»ä½ä½å ç¡æ³éå å° %sï¼%s ç¡æ³ç·¨è¼¯ %s: æ¯ä¸åçµç«¯æ© ç¡æ³ç·¨è¼¯ %s: ä¸æ¯ä¸åæ­£å¸¸æªæ¡ ç¡æ³è¿½é¨ç¬¦èé£çµ %sï¼%s ç¡æ³æéæªæ¡ %s: %s ç¡æ³æéæ«å­æªæ¡ %s: %s åéå­åä¸æ¯å®ä¸ä½åå­å é¯èª¤ç¼çæ¼å¯è¡ç¨ä¸­ é æå¨ãaãããcãæãiãä¹å¾åºç¾ \ é æä½¿ç¨æ°çç sed å½ä»¤å¾å«æå¤é¤çå­å ãsãå½ä»¤ç RHS ä¸ä¸æ­£ç¢ºçåèå¼ \%d ç¡æ³å° +N æ ~N ä½çºç¬¬ä¸åä½å éæ³ä½¿ç¨ä½åç¬¬ 0 å éºæ¼å½ä»¤ å¤åã!ã å¤åãsãå½ä»¤çé¸é ãgã å¤åãsãå½ä»¤çé¸é ãpã å¤åãsãå½ä»¤çæ¸å¼é¸é  æ²æè¼¸å¥æªæ¡ ä¸å­å¨ä¹åçæ­£è¦è¡¨ç¤ºå¼ ãsãå½ä»¤çæ¸å¼é¸é ä¸è½çºé¶ ä¸æ¯æ´é¸é ãeã è®å %s æåºé¯: %s y å½ä»¤çå­ä¸²é·åº¦ä¸å æªé æçã,ã æªé æçã}ã æªç¥çå½ä»¤: ã%cã ãsãçæªç¥é¸é  æªå¹éçã{ã æªçµæçãsãå½ä»¤ æªçµæçãyãå½ä»¤ æªçµæçä½åæ­£è¦è¡¨ç¤ºå¼ 