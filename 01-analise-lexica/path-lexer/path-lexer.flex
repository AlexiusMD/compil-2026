import java.io.InputStreamReader;
%%


%public
%class PathLexer
%integer
%unicode
%line


%{

public static int ID = 257;
public static int DRIVE = 258;

/**
   * Runs the scanner on input files.
   *
   * This is a standalone scanner, it will print any unmatched
   * text to System.out unchanged.
   *
   * @param argv   the command line, contains the filenames to run
   *               the scanner on.
   */
  public static void main(String argv[]) {
    PathLexer scanner;
    if (argv.length == 0) {
      try {        
          // scanner = new PathLexer( System.in );
          scanner = new PathLexer( new InputStreamReader(System.in) );
          while ( !scanner.zzAtEOF ) 
	        System.out.println("line: " + (scanner.yyline + 1) + " - token: "+scanner.yylex()+"\t<"+scanner.yytext()+">");
        }
        catch (Exception e) {
          System.out.println("Unexpected exception:");
          e.printStackTrace();
        }
        
    }
    else {
      for (int i = 0; i < argv.length; i++) {
        scanner = null;
        try {
          scanner = new PathLexer( new java.io.FileReader(argv[i]) );
          while ( !scanner.zzAtEOF ) 	
                System.out.println("line: " + (scanner.yyline + 1) + " - token: "+scanner.yylex()+"\t<"+scanner.yytext()+">");
        }
        catch (java.io.FileNotFoundException e) {
          System.out.println("File not found : \""+argv[i]+"\"");
        }
        catch (java.io.IOException e) {
          System.out.println("IO error scanning file \""+argv[i]+"\"");
          System.out.println(e);
        }
        catch (Exception e) {
          System.out.println("Unexpected exception:");
          e.printStackTrace();
        }
      }
    }
  }


%}

DIGIT=		[0-9]
LETTER=   [a-zA-Z]|{DIGIT}|_
WHITESPACE=	[ \t]
LineTerminator = \r|\n|\r\n    

%%

{LETTER}":"            { return DRIVE;}
({LETTER})({LETTER})*  { return ID;}

"\\" |
"."                         {return yytext().charAt(0);}
{WHITESPACE}+               { }
{LineTerminator}		{}
.          {System.out.println(yyline+1 + ": caracter invalido: "+yytext());}
