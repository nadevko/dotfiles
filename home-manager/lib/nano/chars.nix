{
  brackets = ''
    Set the characters treated as closing brackets when justifying paragraphs.
    This may not include blank characters. Only closing punctuation (see set
    punct), optionally followed by the specified closing brackets, can end
    sentences. The default value is ""')>]}".
  '';
  matchbrackets = ''
    Specify the opening and closing brackets that can be found by bracket
    searches. This may not include blank characters. The opening set must come
    before the closing set, and the two sets must be in the same order. The
    default value is "(<[{)>]}".
  '';
  punct = ''
    Set the characters treated as closing punctuation when justifying
    paragraphs. This may not include blank characters. Only the specfified
    closing punctuation, optionally followed by closing brackets (see brackets),
    can end sentences. The default value is "!. ?".
  '';
  quotestr = ''
    Set the regular expression for matching the quoting part of a line. The
    default value is "^([ \t]*([!#%:;>|}]|//))+". (Note that \t stands for an
    actual Tab character). This makes it possible to rejustify blocks of quoted
    text when composing email, and to rewrap blocks of line comments when
    writing source code.
  '';
  speller = ''
    Use the given program to do spell checking and correcting, instead of using
    the built-in corrector that calls hunspell(1) or spell(1).
  '';
  whitespace = ''
    Set the two characters used to indicate the presence of tabs and spaces.
    They must be single-column characters. The default pair for a UTF-8 locale
    is "»⋅", and for other locales ">. ".
  '';
  wordchars = ''
    Specify which other characters (besides the normal alphanumeric ones) should
    be considered as parts of words. When using this option, you probably want
    to unset wordbounds.
  '';
}
