unit Unit1;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,System.UITypes, System.Variants,
  System.Classes, Vcl.Graphics, System.Rtti,system.StrUtils,system.Math,System.Generics.Collections,
  Vcl.StdCtrls, Vcl.Controls,system.RegularExpressions,system.DateUtils,system.Diagnostics,system.IOUtils,
   Vcl.Forms, Vcl.Dialogs, Vcl.WinXCtrls, Vcl.ExtDlgs;
type
  TFadventofcod = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    CbJour: TComboBox;
    CbExo: TComboBox;
    Memo2: TMemo;
    Button1: TButton;
    Label4: TLabel;
    edFic: TEdit;
    cbAn: TComboBox;
    Label3: TLabel;
    cbTest: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    ActivityIndicator1: TActivityIndicator;
    Memo3: TMemo;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbTime: TLabel;
    lbProc: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CbExoClick(Sender: TObject);
    procedure AddLog(Const S: String);
    function MsToTimeString(ms: int64): string;
    function NbOccu(Ori,Occ:String):int64;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BeginTraitement;
    procedure EndTraitement;
  private
    { Déclarations privées }
    FichierOuvert: string;
    Fichier: Text;
    Chemin: String;
    Annee:String;
    //NomFichier:string;
    function getLigne(NomFichier: string): string;
    function FinDeFichier: boolean;
    procedure FermeFichier;
    procedure OuvreFichier(NomFichier: string);
    procedure AfficheResultat(Jour, Exercice: byte; Reponse: uint64);
    procedure AfficheLog(Jour, Exercice: byte; Log: uint64 ;Tps:string);
    function BinToInt64(Bin: string): int64;
    function VisuFic(NomFichier:string):string;
    //function Cpte(ch:string;s:string):Integer;
  public
    { Déclarations publiques }

    procedure Jour01_1;
    procedure Jour01_2;
    procedure Jour02_1;
    procedure Jour02_2;
    procedure Jour03_1;
    procedure Jour03_2;
    procedure Jour04_1;
    procedure Jour04_2;
    procedure Jour05_1;
    procedure Jour05_2;
    procedure Jour06_1;
    procedure Jour06_2;
    procedure Jour07_1;
    procedure Jour07_2;
    procedure Jour08_1;
    procedure Jour08_2;
    procedure Jour09_1;
    procedure Jour09_2;
    procedure Jour10_1;
    procedure Jour10_2;
    procedure Jour11_1;
    procedure Jour11_2;
    procedure Jour12_1;
    procedure Jour12_2;
    procedure Jour13_1;
    procedure Jour13_2;
    procedure Jour14_1;
    procedure Jour14_2;
    procedure Jour15_1;
    procedure Jour15_2;
    procedure Jour16_1;
    procedure Jour16_2;
    procedure Jour17_1;
    procedure Jour17_2;
    procedure Jour18_1;
    procedure Jour18_2;
    procedure Jour19_1;
    procedure Jour19_2;
    procedure Jour20_1;
    procedure Jour20_2;
    procedure Jour21_1;
    procedure Jour21_2;
    procedure Jour22_1;
    procedure Jour22_2;
    procedure Jour23_1;
    procedure Jour23_2;
    procedure Jour24_1;
    procedure Jour24_2;
    procedure Jour25_1;
    procedure Jour25_2;
    procedure TemplateJour;
  end;
var
  Fadventofcod: TFadventofcod;
  i :uint64;
  j: uint64;
  k:uint64;
  m:int64;
  n:int64;
  p:integer;
  flag:boolean;
  nblig:uint64;
  lig:integer;
  Log:uint64;
  Tps:string;
  ncol:integer;
  tim:TStopwatch;
  limit:uint64;
  total:uint64;
   Result:uint64;
   Tab:Tarray<string>;
   diffe:integer;
  Indic1:Tlist<integer>;
  Indic2:Tlist<integer>;
  Val0,Val1,Val2,Val3:integer;
  Ecar:Tlist<integer>;
  Sign1,Sign2,cpe:integer;
  T_nb : array[0..9]  of string =('zero','one','two','three','four','five','six','seven','eight','nine');
  T_chif : array[0..9]  of string =('0','1','2','3','4','5','6','7','8','9');
  alpha : array[1..52] of string = ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
implementation
{$R *.dfm}


procedure TFadventofcod.AfficheResultat(Jour, Exercice: byte; Reponse: uint64);
begin
  Memo1.Lines.Add('Jour ' + Jour.ToString + ' Exercice ' + Exercice.ToString +
    ' Reponse ' + Reponse.ToString);
end;
 procedure TFadventofcod.AfficheLog(Jour, Exercice: byte; Log: uint64;Tps:string );
begin
  Memo3.Lines.Add('Jour ' + Jour.ToString + ' Exercice ' + Exercice.ToString );

  Memo3.Lines.Add(  ' Nombre de lignes traitées : ' + Log.ToString );
  Memo3.Lines.Add( 'Temps de traitement :' + Tps);
end;
function TFadventofcod.BinToInt64(Bin: string): int64;
var
  i: integer;
begin
  result := 0;
  for i := 0 to Bin.Length - 1 do
    if (Bin.Chars[i] = '0') then
      result := result * 2
    else
      result := result * 2 + 1;
end;
function TFadventofcod.NbOccu(Ori,Occ:String):int64;
    var
      p:integer;
      begin
          result:=0;
          while AnsiPos(Occ,Ori)<>0 do
            begin
               p:=AnsiPos(Occ,Ori);
               delete (Ori,1,p);
               inc(result);
            end;
      end;
function Cpte(ch:String;s:String): integer;
   var
     i:integer;
   begin
        Result:=0;
        i:=0;
        repeat
              i:=PosEx(ch,s,i+1);
              if i<>0 then
                 Inc(Result);
        until i=0;
   end;
function ArrayCount(const A:array of string):Integer;
  var
    n:integer;
  begin
    Result:=0;
    for n := Low(A) to High(A) do
        if A[n]<>'' then
          inc(Result);

  end;

 procedure TFadventofcod.Button1Click(Sender: TObject);
begin
    memo3.Clear;
     memo2.Clear;
      memo1.Clear;
      lbTime.Caption:='';
     close;
end;

function TFadventofcod.VisuFic(NomFichier: string):string;
 var F:textfile;
    lig : string;
    i:integer;
begin
   //Chemin:='c:\user\delphi\projets\adventofcode\data\';
    Chemin:='\\192.168.1.16\Volume_2\sauvsyn7\user\delphi\projets\adventofcode\data\';
     Annee := cbAn.Text;
     edfic.Text:= NomFichier;
     // MessageDlg(Annee,mtError,mbOKCancel,0) ;
     NomFichier:= Chemin + Annee+'\' + NomFichier;
     //OpenTextFileDialog1.Execute();
     //if OpenTextFileDialog1.Execute then

     AssignFile(F,NomFichier);
     reset(F);
     i:=0;
     memo2.text:='';
     while not Eof(F) do
           begin
             i:=i+1;
             readln(F,lig);
             Memo2.Lines.add(i.ToString + '  '+ lig);
           end;
     CloseFile(F);
end;

procedure TFadventofcod.CbExoClick(Sender: TObject);
var

methode:trttimethod;

begin
   Memo1.Lines.Clear;
   lbTime.Caption:='';
   lbproc.Caption:='';
   memo2.Lines.Clear;
   memo3.Lines.Clear;
  if (CbJour.Text<>'') and (CbExo.Text<>'') then
    begin

            methode:=TRttiContext.Create.GetType(TFadventofcod).GetMethod('Jour'+CbJour.Text+'_'+CbExo.Text) ;
            methode.Invoke(FAdventofcod,[]);
            tim.Start;
      end
      else
      begin
             // https://adventofcode.com/2021/day/1
        Jour01_1;
        Jour01_2;
        // https://adventofcode.com/2021/day/2
        Jour02_1;
        Jour02_2;
        // https://adventofcode.com/2021/day/3
        Jour03_1;
        Jour03_2;
        // https://adventofcode.com/2021/day/4
        Jour04_1;
        Jour04_2;
        // https://adventofcode.com/2021/day/5
        Jour05_1;
        Jour05_2;
        // https://adventofcode.com/2021/day/6
        Jour06_1;
        Jour06_2;
        // https://adventofcode.com/2021/day/7
        Jour07_1;
        Jour07_2;
        // https://adventofcode.com/2021/day/8
        Jour08_1;
        Jour08_2;
        // https://adventofcode.com/2021/day/9
        Jour09_1;
        Jour09_2;
        // https://adventofcode.com/2021/day/10
        Jour10_1;
        Jour10_2;
        // https://adventofcode.com/2021/day/11
        Jour11_1;
        Jour11_2;
        // https://adventofcode.com/2021/day/12
        Jour12_1;
        Jour12_2;
        // https://adventofcode.com/2021/day/13
        Jour13_1;
        Jour13_2;
        // https://adventofcode.com/2021/day/14
        Jour14_1;
        Jour14_2;
        // https://adventofcode.com/2021/day/15
        Jour15_1;
        Jour15_2;
        // https://adventofcode.com/2021/day/16
        Jour16_1;
        Jour16_2;
        // https://adventofcode.com/2021/day/17
        Jour17_1;
        Jour17_2;
        // https://adventofcode.com/2021/day/18
        Jour18_1;
        Jour18_2;
        // https://adventofcode.com/2021/day/19
        Jour19_1;
        Jour19_2;
        // https://adventofcode.com/2021/day/20
        Jour20_1;
        Jour20_2;
        // https://adventofcode.com/2021/day/21
        Jour21_1;
        Jour21_2;
        // https://adventofcode.com/2021/day/22
        Jour22_1;
        Jour22_2;
        // https://adventofcode.com/2021/day/23
        Jour23_1;
        Jour23_2;
        // https://adventofcode.com/2021/day/24
        Jour24_1;
        Jour24_2;
        // https://adventofcode.com/2021/day/25
        Jour25_1;
        Jour25_2;

      end;
end;

procedure TFadventofcod.FormCreate(Sender: TObject);
var
methode: TRttiMethod;
NomdeLaProcedure: string;
begin
  for methode in TRttiContext.Create.GetType(TFadventofcod).GetMethods  do
      begin
         NomdeLaProcedure:=methode.Name;
//         if(NomdeLaProcedure.StartsWith('Jour')) then
//              begin
//
//
//              end;
      end;

end;


procedure TFadventofcod.FermeFichier;
begin
  if not FichierOuvert.IsEmpty then
  begin
    closefile(Fichier);
    FichierOuvert := '';
  end;
end;
function TFadventofcod.FinDeFichier: boolean;
begin
  result := (FichierOuvert = '') or eof(Fichier);
end;

procedure TFadventofcod.FormShow(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

function TFadventofcod.getLigne(NomFichier: string): string;
begin
     //Chemin:='c:\user\delphi\projets\adventofcode\data\';
     Chemin:='\\192.168.1.16\Volume_2\sauvsyn7\user\delphi\projets\adventofcode\data\';
     Annee := cbAn.Text;
     // MessageDlg(Annee,mtError,mbOKCancel,0) ;
     NomFichier:= Chemin + Annee+'\' + NomFichier;
      //MessageDlg(NomFichier,mtError,mbOKCancel,0) ;
  if (NomFichier <> FichierOuvert) then
    OuvreFichier(NomFichier);
  if (not FinDeFichier) then
    readln(Fichier, result);
  result := result.Trim;
end;
procedure TFadventofcod.Jour01_1;
 Const
  CNumeroFichier = '01'; // 2 chiffres, en alpha
  CJour = 1; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Valeur_Precedente: word;
  Nb_Increments: int64;
  Calib : byte;
  Caract : string;
  Valeur: int64;
  Valeur_Ligne: word;
  diffe: integer;

  Indic1:Tlist<integer>;
  Indic2:Tlist<integer>;

  Total : int64;
begin
   tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
   if cbTest.Checked=true then
      VisuFic('input-t' + CNumeroFichier + '.txt')
    else
      VisuFic('input-' + CNumeroFichier + '.txt');
   PremiereLigneTraitee := false;
   Valeur_Precedente := 0;
   Nb_Increments := 0;
   Valeur :=0;

   Total:=0 ;
  case Annee.ToInteger of
       2021 :
            begin
                nblig:=0;
                Total:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;
                    if PremiereLigneTraitee then
                    begin
                      if Valeur_Ligne > Valeur_Precedente then
                        inc(Nb_Increments);
                      Valeur_Precedente := Valeur_Ligne;
                    end
                    else
                    begin
                      Valeur_Precedente := Valeur_Ligne;
                      PremiereLigneTraitee := true;
                    end;
                  except
                  end;
                until FinDeFichier;
                 FermeFichier;
                 AfficheResultat(Cjour, CExercice, Nb_Increments);
            end;
       2022 :
            begin
              nblig:=0;
                Total:=0;
                 repeat
                     if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                     if ligne <>'' then
                       begin
                        try
                           Valeur_Ligne := Ligne.ToInteger;
                           if PremiereLigneTraitee then
                          begin
                            Valeur:=Valeur + Valeur_Ligne;
                          end
                          else
                          begin
                            Valeur:=Valeur_Ligne;

                            PremiereLigneTraitee := true;
                          end;
                        except

                        end;
                       end
                       else
                       begin
                            if Valeur>Total then Total:=Valeur;
                            Valeur:=0;
                        end;

                 until FinDeFichier;
                 Result:=Valeur;

            end;
       2023 :
            begin
                 // Total:=0;
                 nblig:=0;
                Total:=0;
                 repeat
                     if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                     if Ligne <>'' then
                       begin
                        try
                              Calib:=0;
                              for j := 0 to length(Ligne)-1 do
                                 if (Ligne.Chars[j] in ['0' .. '9']) then
                                  begin
                                     Calib:=StrToInt(Ligne.Chars[j])*10;
                                     Break;
                                  end;
                              for j := length(Ligne)-1 downto 0 do
                                 if (Ligne.Chars[j] in ['0' .. '9']) then
                                  begin
                                     Calib:=Calib+StrToInt(Ligne.Chars[j]);
                                     Break;
                                  end;
                        except
                        end;
                       end;
                        Valeur:=Valeur+Calib;
                 until FinDeFichier;
                 Result:=Valeur;

            end;

            2024 :
            begin
                nblig:=0;
                Total:=0;
                Indic1:=Tlist<integer>.Create;
                Indic2:=Tlist<integer>.Create;
                 repeat
                     if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                     if Ligne <>'' then
                       begin
                        try
                            Tab:=Ligne.Split(['  ']);
                            Indic1.Add( strtoint(Tab[0]));
                            Indic2.Add( strtoint(Tab[1]));

                        except

                        end;
                       end;
//
                   nblig:=nblig+1;

                 until FinDeFichier;
                 Indic1.Sort;
                 Indic2.Sort;
                 for i:= 0 to nblig-1 do
                     begin
                        diffe:=Abs(Indic1.Items[i]-Indic2.Items[i]);
                        Total:=Total+diffe;
                     end;
                 Result:=Total;
                 Indic1.Free;
                 Indic2.Free;
                 // MessageDlg('lig:'+nblig.ToString,mtError,mbOKCancel,0) ;
            end;

            2025 :
            begin
              nblig:=0;
                Total:=0;
                 repeat
                     if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                     if Ligne <>'' then
                       begin
                        try
                           Valeur_Ligne := Ligne.ToInteger;
                           if PremiereLigneTraitee then
                          begin
                            Valeur:=Valeur + Valeur_Ligne;
                          end
                          else
                          begin
                            Valeur:=Valeur_Ligne;

                            PremiereLigneTraitee := true;
                          end;
                        except

                        end;
                       end
                       else
                       begin
                            if Valeur>Total then Total:=Valeur;
                            Valeur:=0;
                        end;

                 until FinDeFichier;
                 Result:=Valeur;
                 //MessageDlg('lig:'+nblig.ToString,mtError,mbOKCancel,0) ;
                 
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );

  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
   lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);

end;
procedure TFadventofcod.Jour01_2;
Const
  CNumeroFichier = '02'; // 2 chiffres, en alpha
  CJour = 1; // Numéro du jour
  CExercice = 2; // Numéro exercice
  //T_nb : array[0..9]  of string =('zero','one','two','three','four','five','six','seven','eight','nine');
var
   PremiereLigneTraitee:boolean;
   Valeur:int64;
   //Result:int64;
   Total:int64;
   i,j,y,tmpI:integer;
  TroisPremieresLignesTraitees: boolean;
  Valeur_Ligne: word;
  Ligne: string;
  Valeur_1, Valeur_2: int64;
  Val1,Val2:integer;
  Nb_Increments: int64;
  Tab_Valeurs: array  of int64;
  DimTab:integer;
  Num_Ligne: int64;
  diffe:integer;
  Indic1:Tlist<integer>;
  Indic2:Tlist<integer>;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
   if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');

   DimTab:=0;
  TroisPremieresLignesTraitees := false;
  Valeur_1 := 0;
  Valeur_2 := 0;
  Nb_Increments := 0;
  Num_Ligne := 0;
  Total:=0;
  case Annee.ToInteger of
       2021 :
           begin
              Tab_Valeurs[0] := 0;
              Tab_Valeurs[1] := 0;
              Tab_Valeurs[2] := 0;
              nblig:=0;
                Total:=0;
           repeat
              if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
              try
                Valeur_Ligne := Ligne.ToInteger;
                // On fait le cumul avec les valeurs existantes avant comparaison
                case Num_Ligne mod 3 of
                  0:
                    begin
                      inc(Tab_Valeurs[1], Valeur_Ligne);
                      inc(Tab_Valeurs[2], Valeur_Ligne);
                    end;
                  1:
                    begin
                      inc(Tab_Valeurs[0], Valeur_Ligne);
                      inc(Tab_Valeurs[2], Valeur_Ligne);
                    end;
                  2:
                    begin
                      inc(Tab_Valeurs[0], Valeur_Ligne);
                      inc(Tab_Valeurs[1], Valeur_Ligne);
                    end;
                end;
                // Comparaison des valeurs à partir de la quatrième ligne remplie
                if TroisPremieresLignesTraitees then
                begin
                  case Num_Ligne mod 3 of
                    0:
                      begin
                        Valeur_1 := Tab_Valeurs[0];
                        Valeur_2 := Tab_Valeurs[1];
                      end;
                    1:
                      begin
                        Valeur_1 := Tab_Valeurs[1];
                        Valeur_2 := Tab_Valeurs[2];
                      end;
                    2:
                      begin
                        Valeur_1 := Tab_Valeurs[2];
                        Valeur_2 := Tab_Valeurs[0];
                      end;
                  end;
                  if Valeur_2 > Valeur_1 then
                    inc(Nb_Increments);
                end
                else if (Num_Ligne = 2) then
                  TroisPremieresLignesTraitees := true;
                // On initialise la valeur de la ligne en cours pour partir sur un nouveau cycle de 3 lignes
                Tab_Valeurs[Num_Ligne mod 3] := Valeur_Ligne;
                // Passage à la ligne suivante
                inc(Num_Ligne);
              except
              end;
            until FinDeFichier;
             FermeFichier;
             AfficheResultat(Cjour, CExercice, Nb_Increments);
           end;
       2022 :
            begin
                 PremiereLigneTraitee := false;
                 Valeur :=0;
                 //Total:=0 ;

                i:=0;
                j:=0;
                nblig:=0;
                Total:=0;
             repeat
                if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                     if ligne <>'' then
                       begin
                        try
                           Valeur_Ligne := Ligne.ToInteger;
                           //if PremiereLigneTraitee then
                          //begin
                            Valeur:=Valeur + Valeur_Ligne;
                         // end
                          //else
                          //begin
                            //Valeur:=Valeur_Ligne;

                            //PremiereLigneTraitee := true;
                          //end;
                        except

                        end;
                       end
                       else
                       begin
                            j:=i+1;
                            SetLength(Tab_Valeurs,j);
                            Tab_Valeurs[i]:=Valeur;
                            i:=i+1;
                            Valeur:=0;
                            DimTab:=j;
                        end;

             until FinDeFichier;

              //DimTab:=i;
              for y := 0 to DimTab-1 do
                  for j := DimTab-1 downto 0 do
                      if Tab_Valeurs[y]>Tab_Valeurs[j] then
                         begin
                            tmpI:=Tab_Valeurs[j];
                            Tab_Valeurs[j]:=Tab_Valeurs[y];
                            Tab_Valeurs[y]:=tmpI;
                         end;




             //Total:=Tab_Valeurs[DimTab-2] + Tab_Valeurs[DimTab-3]+Tab_Valeurs[DimTab-4] ;
             Total:=Tab_Valeurs[DimTab-4] ;
             Result:=Total;


            end;
        2023:
            begin
                nblig:=0;
                Total:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    //Valeur_Ligne := Ligne.ToInteger;
                    for I := 0 to 9 do
                        begin
                           //Valeur_ligne = replace_str (ligne, ,);
                        end;

                  except
                  end;
                until FinDeFichier;

            end;

        2024:
           begin

                Indic1:=Tlist<integer>.Create;
                Indic2:=Tlist<integer>.Create;
                nblig:=0;
                Total:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  if Ligne <>'' then
                       begin
                          try

                             Tab:=Ligne.Split(['  ']);
                             Indic1.Add( strtoint(Tab[0]));
                             Indic2.Add( strtoint(Tab[1]));

                          except
                          end;
                       end;
                       nblig:=nblig+1;
                until FinDeFichier;
                Indic1.Sort;
                 Indic2.Sort;
                 for i:= 0 to nblig-1 do
                     begin
                        Val1:=Indic1.Items[i];
                        Val2:=0;
                          for j := 0 to nblig-1 do
                              begin
                                 if Indic2.Items[j]=Val1 then
                                    Val2:=Val2+1
                                  else
                                    Val2:=Val2;
                              end;
                        Total:=Total+(Val1*Val2);
                     end;
                 Result:=Total;
                 Indic1.Free;
                 indic2.Free;
                  //MessageDlg('lig:'+nblig.ToString,mtError,mbOKCancel,0) ;
            end;

        2025:
          begin
                nblig:=0;
                Total:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;


   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
   lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);

   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);

end;
procedure TFadventofcod.Jour02_1;
Const
  CNumeroFichier = '03'; // 2 chiffres, en alpha
  CJour = 2; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  Ligne: string;
  Valeur_Ligne: word;
  Tab: tarray<string>;
  Operation,MatchE,MatchM: string;
  Profondeur: int64;
  DistanceParcourrue: int64;
  ContLign:tarray<string>;
  ContData:tarray<string>;
  Color:tarray<string>;
  Coul:tarray<string>;
  Cont:string;
  Sign1,Sign2:integer;
  Game :integer;
  R,G,B : integer;
  NumLig:integer;
  //Result:int64;
  Total: integer;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
  Profondeur := 0;
  DistanceParcourrue := 0;
  NumLig:=0;
  Result:=0;
    case Annee.ToInteger of
       2021 :
           begin
            nblig:=0;
                Total:=0;
              repeat
                if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                try
                  Tab := Ligne.Trim.Split([' ']);
                  if (Length(Tab) = 2) then
                  begin
                    Valeur_Ligne := Tab[1].ToInteger;
                    Operation := Tab[0].ToLower;
                    if (Operation = 'up') then
                      dec(Profondeur, Valeur_Ligne)
                    else if (Operation = 'down') then
                      inc(Profondeur, Valeur_Ligne)
                    else if (Operation = 'forward') then
                      inc(DistanceParcourrue, Valeur_Ligne);
                  end;
                except
                end;
              until FinDeFichier;
              Result:=Profondeur * DistanceParcourrue;
           end;
       2022 :

            begin
                nblig:=0;
                Total:=0;
                 repeat
                   if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                   try
                     Tab := Ligne.Trim.Split([' ']);
                     MatchE:= Tab[0];
                     MatchM:=Tab[1];
                     if MatchM = 'X' then Total:=Total+1;
                     if MatchM = 'Y' then Total:=Total+2;
                     if MatchM = 'Z' then Total:=Total+3;
                     if ((MatchE='A') and (MatchM='X'))or((MatchE='B') and (MatchM='Y'))or((MatchE='C') and (MatchM='Z'))  then Total:=Total+3
                        else
                        begin
                            if ((MatchE='A') and (MatchM='Z'))or((MatchE='B') and (MatchM='X'))or ((MatchE='C') and (MatchM='Y'))  then Total:= Total + 0
                               else
                               begin
                                   Total:= Total + 6;
                               end;
                        end;


                   except
                   end;

                 until FinDeFichier;
                 Result :=Total;
             //MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
         2023:
             begin
                Game:=0;
                R:=12;
                G:=13;
                B:=14;
                flag:=false;
                Cont:='';
                nblig:=0;
                Total:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  if Ligne <>'' then
                  begin
                  try
                    ContLign := Ligne.Split([':']);
                    delete(ContLign[0],1,5);
                    cont:=ContLign[0];
                    ContData:=ContLign[1].Split([';']) ;
                    i:=length(ContData);
                      for j:=0  to i-1   do
                       begin
                          Color:=ContData[j].Split([',']) ;
                       k:=length(Color);
                       for m:=0  to k-1   do
                           begin
                            Coul:=Color[m].trim.Split([' ']);
                              if (Coul[1]='red') and (coul[0].ToInteger >R) then cont:='0' ;

                              if (Coul[1]='blue') and (coul[0].ToInteger >B) then cont:='0';
                              if (Coul[1]='green') and (coul[0].ToInteger >G) then cont:='0';
                              //MessageDlg(Coul[1],mtError,mbOKCancel,0) ;
                           end;
                       end;
                    Game := Game + Cont.ToInteger;
                    //MessageDlg(concat(ContData[0].ToLower[2], 'l',inttostr(j)),mtError,mbOKCancel,0) ;
                  except
                  end;
                  end;
                until FinDeFichier;
                 Result:=Game;
            end;

         2024:
            begin
                nblig:=0;
                Total:=0;
                repeat
                  Indic1:=Tlist<integer>.Create;
                  Val2:=0;
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  Sign1:=0;
                  Sign2:=0;
                  if Ligne <>'' then
                       begin
                          try
                             Tab:=Ligne.Split([' ']);
                             m:=ArrayCount(Tab);
                             for i:=0 to m-1 do
                               begin
                                  Indic1.Add( strtoint(Tab[i]));
                                  //MessageDlg('Indic1 : ' + inttostr(Indic1.Items[i]),mtError,mbOKCancel,0) ;
                               end;
                          except
                          end;
                          for j:=0 to m-2 do
                                 begin
                                  if j < m-2 then
                                   begin
                                      Val1:=indic1.Items[j]-indic1.Items[j+1];
                                       val1:=abs(val1);
                                        //MessageDlg('val1 : ' + inttostr(Val1),mtError,mbOKCancel,0) ;
                                        if (Val1>=1) and (Val1<=3) then
                                           Val2:=1
                                           else
                                            if ((Val1>3) or (Val1=0)) then
                                                begin
                                                Val2:=0;
                                                break;
                                                end;
                                        if (indic1.Items[j]>indic1.Items[j+1]) and (indic1.Items[j+1]<indic1.Items[j+2]) then
                                            begin
                                              val2:=0;
                                              break;
                                            end ;
                                          if (indic1.Items[j]<indic1.Items[j+1]) and (indic1.Items[j+1]>indic1.Items[j+2]) then
                                          begin
                                            val2:=0;
                                            break;
                                          end;
                                      if (indic1.Items[j]=indic1.Items[j+1])  then
                                      begin
                                        val2:=0;
                                        break;
                                      end;
                                   end
                                   else
                                   if j=m-2 then
                                      begin
                                          Val1:=indic1.Items[j]-indic1.Items[j+1];
                                          val1:=abs(val1);
                                          if (Val1>=1) and (Val1<=3) then
                                             Val2:=1
                                             else
                                              if ((Val1>3) or (Val1=0)) then
                                                  begin
                                                  Val2:=0;
                                                  break;
                                                  end;
                                          if (indic1.Items[j-1]>indic1.Items[j]) and (indic1.Items[j]<indic1.Items[j+1]) then
                                            begin
                                              val2:=0;
                                              break;
                                            end ;
                                          if (indic1.Items[j-1]<indic1.Items[j]) and (indic1.Items[j]>indic1.Items[j+1]) then
                                          begin
                                            val2:=0;
                                            break;
                                          end;
                                          if (indic1.Items[j]=indic1.Items[j-1])  then
                                            begin
                                              val2:=0;
                                              break;
                                            end;
                                      end;
                                 end;
                       Total:=Total+Val2;
                       Indic1.Free;
                       end;
                       nblig:=nblig+1;
                until FinDeFichier;
                  Result:=Total;
            end;

         2025:
            begin
                nblig:=0;
                Total:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
            end;

   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;

  FermeFichier;
 lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour02_2;
Const
  CNumeroFichier = '04'; // 2 chiffres, en alpha
  CJour = 2; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  Ligne: string;
  Valeur_Ligne: word;
  Tab: tarray<string>;
  Operation,MatchE,MatchM: string;
  Profondeur,Result,Total: int64;
  Objectif: int64;
  DistanceParcourrue: int64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
  Profondeur := 0;
  Objectif := 0;
  DistanceParcourrue := 0;
   case Annee.ToInteger of
       2021 :
           begin
               nblig:=0;
                Total:=0;
              repeat
                if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                try
                  Tab := Ligne.Trim.Split([' ']);
                  if (Length(Tab) = 2) then
                  begin
                    Valeur_Ligne := Tab[1].ToInteger;
                    Operation := Tab[0].ToLower;
                    if (Operation = 'up') then
                      dec(Objectif, Valeur_Ligne)
                    else if (Operation = 'down') then
                      inc(Objectif, Valeur_Ligne)
                    else if (Operation = 'forward') then
                    begin
                      inc(DistanceParcourrue, Valeur_Ligne);
                      inc(Profondeur, Valeur_Ligne * Objectif);
                    end;
                  end;
                except
                end;
              until FinDeFichier;
              Result:= Profondeur * DistanceParcourrue;
           end;
       2022 :
            begin
             Result:=0;
             nblig:=0;
                Total:=0;
             repeat
                   if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                   try
                     Tab := Ligne.Trim.Split([' ']);
                     MatchE:= Tab[0];
                     MatchM:=Tab[1];
                     if MatchM = 'X' then Total:=Total+0;
                     if MatchM = 'Y' then Total:=Total+3;
                     if MatchM = 'Z' then Total:=Total+6;
                     if (MatchM='Y') and (MatchE='A') then Total:=Total+1;
                     if (MatchM='Y') and (MatchE='B') then Total:=Total+2;
                     if (MatchM='Y') and (MatchE='C') then Total:=Total+3;
                     if (MatchM='X') and (MatchE='A') then Total:=Total+3;
                     if (MatchM='X') and (MatchE='B') then Total:=Total+1;
                     if (MatchM='X') and (MatchE='C') then Total:=Total+2;
                     if (MatchM='Z') and (MatchE='A') then Total:=Total+2;
                     if (MatchM='Z') and (MatchE='B') then Total:=Total+3;
                     if (MatchM='Z') and (MatchE='C') then Total:=Total+1;
                   except
                   end;

             until FinDeFichier;
             Result:=Total;
             //MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
         2023:
            begin
                nblig:=0;
                Total:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                  inc(nblig);
                until FinDeFichier;
            end;
         2024:
            begin

               nblig:=0;
                Total:=0;
                repeat
                  Indic1:=Tlist<integer>.Create;
                  Val2:=0;
                  cpe:=0;
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  Sign1:=0;
                  Sign2:=0;
                  if Ligne <>'' then
                       begin
                          try
                             Tab:=Ligne.Split([' ']);
                             m:=ArrayCount(Tab);
                             for i:=0 to m-1 do
                               begin
                                  Indic1.Add( strtoint(Tab[i]));
                                  //MessageDlg('Indic1 : ' + inttostr(Indic1.Items[i]),mtError,mbOKCancel,0) ;
                               end;
                            for j:=0 to m-1 do
                                 begin
                                  if j+1 <= m-1 then
                                   begin
                                      Val1:=indic1.Items[j]-indic1.Items[j+1];
                                       val1:=abs(val1);
                                        //MessageDlg('val1 : ' + inttostr(Val1),mtError,mbOKCancel,0) ;
                                        if (Val1>=1) and (Val1<=3) then
                                           Val2:=1
                                           else
                                            if ((Val1>3) ) then
                                                begin
                                                Val2:=0;
                                                break;
                                                end;
//                                     if (indic1.Items[m-1]=indic1.Items[m-2])  then
//                                            begin
//                                              val2:=0;
//                                              cpe:=cpe+1;
//                                              //break;
//                                            end;
                                   end;
                                  end;
                            for j:=0 to m-1 do
                                   begin
                                   if (indic1.Items[j]>indic1.Items[j+1]) and (indic1.Items[j+1]<indic1.Items[j+2]) then
                                            begin
                                              val2:=0;
                                              cpe:=cpe+1;
//                                              break;
                                            end ;
                                   if (indic1.Items[j]<indic1.Items[j+1]) and (indic1.Items[j+1]>indic1.Items[j+2]) then
                                              begin
                                                val2:=0;
                                                cpe:=cpe+1;
//                                               break;
                                              end;
                                   if (indic1.Items[j]=indic1.Items[j+1])  then
                                      begin
                                        val2:=0;
                                        cpe:=cpe+1;
//                                        break;
                                      end;
                                      if cpe>1 then
                                            begin
                                              cpe:=cpe-1;
                                              Val2:=1;
                                            end;
//                                   //end ;
////                                   if (indic1.Items[m-1]=indic1.Items[m-2])  then
////                                            begin
////                                              val2:=0;
////                                              cpe:=cpe+1;
////                                              //break;
////                                            end;
//                                     end;
//                                   else
//                                   if j=m-2 then
//                                      begin
//                                          Val1:=indic1.Items[j]-indic1.Items[j+1];
//                                          val1:=abs(val1);
//                                          if (Val1>=1) and (Val1<=3) then
//                                             Val2:=1
//                                             else
//                                              if ((Val1>3)) then
//                                                  begin
//                                                  Val2:=0;
//                                                  break;
//                                                  end;
//                                          if (indic1.Items[j-1]>indic1.Items[j]) and (indic1.Items[j]<indic1.Items[j+1]) then
//                                            begin
//                                              val2:=0;
//                                               cpe:=cpe+1;
//                                              break;
//                                            end ;
//                                          if (indic1.Items[j-1]<indic1.Items[j]) and (indic1.Items[j]>indic1.Items[j+1]) then
//                                              begin
//                                                val2:=0;
//                                                 cpe:=cpe+1;
//                                                break;
//                                              end;
//                                          if (indic1.Items[j]=indic1.Items[j-1])   then
//                                            begin
//                                              val2:=0;
//                                              cpe:=cpe+1;
//                                              break;
//                                            end;
////                                             if cpe=1 then
////                                            begin
////                                              cpe:=cpe-1;
////                                              Val2:=1;
////                                            end;
                                      end;
//                                       if cpe>=1 then
//                                            begin
//                                              cpe:=cpe-1;
//                                              Val2:=0;
//                                            end;
                                   // MessageDlg('cpe : ' + inttostr(cpe),mtError,mbOKCancel,0) ;
                          except

                          end;
//                                 if (indic1.Items[m-1]=indic1.Items[m-2])  then
//                                            begin
//                                              val2:=0;
//                                              cpe:=cpe+1;
//                                              //break;
//                                            end;
//                          if cpe>=1 then
//                            begin
//                              cpe:=cpe-1;
//                              Val2:=0;
//                            end;
                         //MessageDlg('cpe : ' + inttostr(cpe),mtError,mbOKCancel,0) ;
                       Total:=Total+Val2;
                       Indic1.Free;
                       end;
//                       if cpe>=1 then
//                            begin
//                              cpe:=cpe-1;
//                              Val2:=1;
//                            end;
                       //Total:=Total+Val2;
                       nblig:=nblig+1;
                until FinDeFichier;
                  Result:=Total;
            end;
         2025:
            begin
               nblig:=0;
                Total:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                  nblig:=nblig+1;
                until FinDeFichier;
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;

  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour03_1;
type
  TTabBin = array [0 .. 1] of int64;

Const
  CNumeroFichier = '05'; // 2 chiffres, en alpha
  CJour = 3; // Numéro du jour
  CExercice = 1; // Numéro exercice
  alpha : array[1..52] of string = ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
var
  Valeur_Ligne: word;
  Total,Nomb : int64;
  Ligne: string;
  GammaRate: integer;
  // composé par les bits les plus présents dans chaque colonne du fichier
  EpsilonRate: integer;
  // composé par les bits les moins présents dans chaque colonne du fichier
  Tab: array of TTabBin; // Nombre d'occurrence de 0/1 par colonne
  //alpha: array[a,b];
  Engine : array of array of integer;
  PremiereLigne: boolean;
  i,j,k,m,n,interm,interm2,Result,taille,Llign: integer;
  Ech1,Ech2,Clef : string;
begin
  tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
  PremiereLigne := true;
   case Annee.ToInteger of
       2021 :
           begin
                result:=0;
                nblig:=0;
                Total:=0;
              repeat
                if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                if (Ligne.Length > 0) then
                  try
                     taille:= ligne.Length;
                    if PremiereLigne then
                    begin
                      setlength(Tab, Ligne.Length);
                      for i := 0 to Length(Tab) - 1 do
                      begin
                        Tab[i][0] := 0;
                        Tab[i][1] := 0;
                      end;
                      PremiereLigne := false;
                    end;
                    for i := 0 to Length(Tab) - 1 do
                      if (Ligne.Chars[i] = '0') then
                        inc(Tab[i][0])
                      else
                        inc(Tab[i][1]);
                  except
                  end;
                  nblig:=nblig+1;
              until FinDeFichier;
              GammaRate := 0;
              EpsilonRate := 0;
              for i := 0 to Length(Tab) - 1 do
                if (Tab[i][1] > Tab[i][0]) then
                begin
                  GammaRate := GammaRate * 2 + 1;
                  EpsilonRate := EpsilonRate * 2 + 0;
                end
                else
                begin
                  GammaRate := GammaRate * 2 + 0;
                  EpsilonRate := EpsilonRate * 2 + 1;
                end;
               Result:=GammaRate*EpsilonRate;
           end;
       2022 :
            begin
                 Result:=0;
                 interm:=0;
                 //interm2:=0;
              nblig:=0;
                Total:=0;
                 repeat
                if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                //k:=0;
                begin
                   //interm2:=interm2 + 1;

                if (Ligne.Length > 0) then
                   k:=0;
                  try
                    taille:=round(Ligne.Length/2);

                   // k:=0;
                     Ech1:= Ligne.substring(0,taille);
                     Ech2:= Ligne.substring(taille,taille);
                     for i:=0 to taille  do

                          for j:=0 to taille  do
                              begin

                            if (Ech2.Chars[j] = Ech1.Chars[i]) and (k =0)  then
                               begin

                                 k:=k+1;
                                 Clef:= Clef + ',' + Ech1.Chars[i];
                                 for m := 1 to 52 do
                                    begin
                                      if Ech2.Chars[j]=alpha[m] then
                                        interm:=interm + m;
                                    end;

                               end;
                            end;
                  except
                  end;
                end;
                nblig:=nblig+1;
              until FinDeFichier;
              Result:=interm;
             //MessageDlg(interm2.ToString,mtError,mbOKCancel,0) ;
            end;
         2023:
            begin
                Total:=0;
                //Result:=0;
                Nomb:=0;
                nblig:=0;
                ncol:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                     //nblig:=nblig+1;
                     ncol:= Ligne.Length;
                     SetLength(engine,nblig,ncol);
                     for i:=0 to ncol do
                         begin
                              //if (Ligne[i]) in T_chif then

                              //else
                             // begin

                             // end;
                            Engine[nblig,i] := StrToInt(Ligne[i]);
                         end;
                       //SetLength(engine,nlig,ncol);
                       //Engine[nlig,
                     //engine:=array[0..nlig,0..ncol] of integer;
                    //Valeur_Ligne := Ligne.ToInteger;
                      //MessageDlg(engine[9,9].ToString,mtError,mbOKCancel,0) ;
                      Total:=Total+Llign;

                  except
                  end;
                   nblig:=nblig+1;
                until FinDeFichier;
                  MessageDlg('col:'+ncol.ToString+'lig:'+nblig.ToString,mtError,mbOKCancel,0) ;
                Result:=Total;
                 
            end;
         2024:
            begin
               nblig:=0;
                Total:=0;
                Val0:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try

                     Val0:=NbOccu(Ligne,'mul(');
                     MessageDlg('val0 :'+ Val0.ToString,mtError,mbOKCancel,0) ;

                  except
                  end;
                   Total:=Total+Val0;
                  nblig:=nblig+1;
                until FinDeFichier;
                Result:=Total;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin
               nblig:=0;
                Total:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                  nblig:=nblig+1;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;


  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour03_2;
Const
  CNumeroFichier = '06'; // 2 chiffres, en alpha
  CJour = 3; // Numéro du jour
  CExercice = 2; // Numéro exercice
  //alpha : array[1..52] of string = ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
var
  Ligne,Ligne1,Ligne2,Ligne3,lett: string;
  NumColonne, NbColonnes: byte;
  Nb0_Oxy, Nb1_Oxy: int64;
  Oxygene_Bin: string;
  Nb0_CO2, Nb1_CO2: int64;
  CO2_Bin: string;
  PremiereLigne: boolean;
  TroisPremieresLignesTraitees: boolean;
  //Valeur_Ligne: word;
  Valeur_Ligne: word;
  Total : int64;
  i,j,k,m,n,nb,interm,taille1,taille2,taille3,Res:integer;
begin
  tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
     PremiereLigne :=false;
     TroisPremieresLignesTraitees:=false;
    NbColonnes := 0;
    NumColonne := 0;
    Oxygene_Bin := '';
    CO2_Bin := '';
      case Annee.ToInteger of
       2021 :
           begin
            repeat
                Nb0_Oxy := 0;
                Nb1_Oxy := 0;
                Nb0_CO2 := 0;
                Nb1_CO2 := 0;
                repeat
                 if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  if (Ligne.Length > 0) then
                    try
                      if PremiereLigne then
                      begin
                        PremiereLigne := false;
                        NbColonnes := Ligne.Length;
                      end;
                      if (Oxygene_Bin.IsEmpty or (Ligne.StartsWith(Oxygene_Bin))) then
                        if (Ligne.Chars[NumColonne] = '0') then
                          inc(Nb0_Oxy)
                        else
                          inc(Nb1_Oxy);
                      if (CO2_Bin.IsEmpty or (Ligne.StartsWith(CO2_Bin))) then
                        if (Ligne.Chars[NumColonne] = '0') then
                          inc(Nb0_CO2)
                        else
                          inc(Nb1_CO2);
                    except
                    end;
                until FinDeFichier;
                          FermeFichier;
                  if (Nb1_Oxy >= Nb0_Oxy) then
                    Oxygene_Bin := Oxygene_Bin + '1'
                  else
                    Oxygene_Bin := Oxygene_Bin + '0';
                  if ((Nb0_CO2 <= Nb1_CO2) and (Nb0_CO2 > 0)) or (Nb1_CO2 = 0) then
                    CO2_Bin := CO2_Bin + '0'
                  else
                    CO2_Bin := CO2_Bin + '1';
                  inc(NumColonne);
                until (NumColonne >= NbColonnes);
               Res:= BinToInt64(Oxygene_Bin) * BinToInt64(CO2_Bin) ;
               Result:=Res;
           end;
       2022 :
            begin
            interm:=0;
                 repeat
                    //Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                    //if (Ligne.Length > 0) then

                       try
                       i:=0;
                       j:=0;
                       n:=0;
                       taille1:=0;
                       taille2:=0;
                       taille3:=0;
                       repeat
                             i:=i+1;
                             if i=1 then Ligne1 := getLigne('input-' + CNumeroFichier + '.txt');
                             if i=2 then Ligne2 := getLigne('input-' + CNumeroFichier + '.txt');
                             if i=3  then Ligne3 := getLigne('input-' + CNumeroFichier + '.txt');
                       //until i=3;
                       taille1:=Ligne1.Length;
                       taille2:=Ligne2.Length;
                       taille3:=Ligne3.Length;
                       for k:=0 to taille1  do
                           lett:= Ligne1.Chars[k];
                           nb :=Cpte(Ligne1.Chars[k],Ligne1);
                           MessageDlg(lett + 'et' + nb.ToString,mtError,mbOKCancel,0) ;
                           if nb=1 then
                           begin
                           for j:=0 to taille2  do
                               //begin
                                n :=Cpte(Ligne1.Chars[k],Ligne2);
                                if n=1   then
                                   begin


                                     //Clef:= Clef + ',' + Ech1.Chars[i];
                                     for m := 1 to 52 do
                                        begin
                                          if Ligne1.Chars[k]=alpha[m] then
                                            interm:=interm + m;
                                        end;

                                   end;
                               end;
                       until i=3;
                        //MessageDlg(nb.ToString + 'et' + n.ToString,mtError,mbOKCancel,0) ;
                       except

                       end;

                 until FinDeFichier;
                 Result:=interm;
                FermeFichier;
             //MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
        2023:
            begin

                nblig:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                     Tab := Ligne.Split([':']);
                     nblig:=nblig+1;
                    Valeur_Ligne := Ligne.ToInteger;
                    //MessageDlg(Tab[0],mtError,mbOKCancel,0) ;
                     //MessageDlg(Tab[0],mtError,mbOKCancel,0) ;
                  except
                  end;
                  MessageDlg(Tab[0],mtError,mbOKCancel,0) ;
                until FinDeFichier;
                result:=nblig;
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else



       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
// Types utilisés pour le Jour 4 : Bingo
type
  TJ4_Case = class
  public
    FNumero: integer;
    FTire: boolean;
    constructor Create(ANumero: integer);
  end;
  TJ4_Grille = array [1 .. 5, 1 .. 5] of TJ4_Case;
  TJ4_Carte = class
  public
    FGrille: TJ4_Grille;
    FGagnante: boolean;
    procedure Numero(ACol, ALig, ANumero: integer); overload;
    function Numero(ACol, ALig: integer): integer; overload;
    function isLigneFinie(ALig: integer): boolean;
    function isColonneFinie(ACol: integer): boolean;
    function isGrilleGagnanteAvecNumero(ANumero: integer): boolean;
    function TotalNumerosNonTires: integer;
    constructor Create;
    destructor Destroy; override;
  end;
  TJ4_ListeDeCartes = class(TObjectList<TJ4_Carte>)
  public
  end;
procedure TFadventofcod.Jour04_1;
Const
  CNumeroFichier = '07'; // 2 chiffres, en alpha
  CJour = 4; // Numéro du jour
  CExercice = 1; // Numéro exercice
 
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  sListeNumeros: string;

  numCol, NumLig, Numero: integer;
  Board: TJ4_Carte;
  ListeCartes: TJ4_ListeDeCartes;
  NumeroTire: integer;

  npot:int64;
  nmain:int64;
  gain:int64;
  Valeur_Ligne: word;
  intermed:tarray<string>;
  pot:Tarray<string>;
  don:tarray<string>;
  Total : int64;


begin
  tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
     case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin
               total:=0;
                nblig:=0;
                gain:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                     Tab := Ligne.Substring(Ligne.IndexOf(':')).Split(['|']);
                     pot:= Tab[0].split([' ']);
                     don:=Tab[1].split([' ']);
                     npot:=length(pot);
                     for i:=0 to npot-1 do
                         pot[i]:=pot[i].Trim;
                     nmain:=length(don);
                     for j:=0 to nmain-1 do
                         don[j]:=don[j].Trim;
                     for i:=0 to npot-1 do
                         begin
                           for j:=0 to nmain-1 do
                               begin
                                 if (pot[i]=don[j]) and not pot[i].IsEmpty then
                                    begin
                                     if gain=0 then gain:=1 else gain:=gain*2;
                                    end;
                               end;
                         end;
                    Valeur_Ligne := Ligne.ToInteger;
                    except
                  end;
                  nblig:=nblig+1;
                  total:=total+gain;
                  gain:=0;
                  //MessageDlg( nblig.ToString,mtError,mbOKCancel,0) ;
                until FinDeFichier;
                result:=total;
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  // Lecture des données et remplissage
  ListeCartes := TJ4_ListeDeCartes.Create;
  try
    PremiereLigneTraitee := false;
    repeat
      if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if PremiereLigneTraitee then
        begin // charge les cartes de jeu
          if Ligne.IsEmpty then
          begin
            //NumLig := 0;
            Board := TJ4_Carte.Create;
            ListeCartes.Add(Board);
          end ;
         // else
         // begin // Charge première ligne = numéros tirés
            //Ligne := Ligne.Replace('  ', ' ');
           //var
            //Tab := Ligne.Split([' ']);
            //if (Length(Tab) <> 5) then
              //raise exception.Create('erreur : ' + Ligne);
            //for numCol := 0 to 4 do
              //Board.Numero(numCol + 1, NumLig + 1, Tab[numCol].Trim.ToInteger);
            //inc(NumLig);
          //end;
        end
        else
        begin // première ligne = numeros tirés
          PremiereLigneTraitee := true;
          sListeNumeros := Ligne;
        end;
      except
      end;
    until FinDeFichier;
    FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
    //AfficheResultat(Cjour, CExercice,Result );
    // Tirage des numéros
//    var
//    Tab := sListeNumeros.Split([',']);
//    var
//    FinTirage := false;
//    for i := 0 to Length(Tab) - 1 do
//    begin
//      NumeroTire := Tab[i].Trim.ToInteger;
//      if (ListeCartes.Count > 0) then
//        for Board in ListeCartes do
//          if Board.isGrilleGagnanteAvecNumero(NumeroTire) then
//          begin
//            AfficheResultat(4, 1, NumeroTire * Board.TotalNumerosNonTires);
//            FinTirage := true;
//            break;
//          end;
//      if FinTirage then
//        break;
//    end;
  finally
    ListeCartes.Free;
  end;
end;
Type
 Tmain=class
    articl:uint64;
    qte:uint64;
 end;
procedure TFadventofcod.Jour04_2;

Const
  CNumeroFichier = '08'; // 2 chiffres, en alpha
  CJour = 4; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  sListeNumeros: string;
  numCol, NumLig, Numero: integer;
  Board, DerniereGrilleGagnante: TJ4_Carte;
  ListeCartes: TJ4_ListeDeCartes;
  NumeroTire, DernierNumeroTire: integer;
  Valeur_Ligne: word;
  Total : uint64;
  gain:uint64;
  pot:tarray<string>;
  don:tarray<string>;
  card:tdictionary<uint64,Tmain>;
  coef:tlist<uint64>;
  main:Tmain;
  npot:uint64;
  nmain:uint64;

begin
  tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
    if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin
                card:=tdictionary<uint64,Tmain>.Create;
                coef:=tlist<uint64>.create;

                total:=0;
                nblig:=0;
                gain:=0;
                begin
                  repeat
                    if cbTest.Checked=true then
                    Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                    else
                   Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                   nblig:=nblig+1;
                     main:=Tmain.create;
                             main.articl:=1;
                             main.qte:=0;
                     card.add(nblig,main);

                 until FinDeFichier;
                 FermeFichier;
                   end;
                   limit:=nblig;
                nblig:=0;

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  //gain:=0;
                  try
                     Tab := Ligne.Substring(Ligne.IndexOf(':')).Split(['|']);
                     pot:= Tab[0].split([' ']);
                     don:=Tab[1].split([' ']);
                     npot:=length(pot);
                     nblig:=nblig+1;
                     coef.Add(1) ;
                     for i:=0 to npot-1 do
                         pot[i]:=pot[i].Trim;
                     npot:=length(pot);
                     nmain:=length(don);
                     for j:=0 to nmain-1 do
                         don[j]:=don[j].Trim;
                      nmain:=length(don);
                      //n:=0;
                      gain:=0;
                      limit:=nblig;
                     for i:=0 to npot-1 do
                     //for j:=0 to nmain-1 do
                         begin
                           for j:=0 to nmain-1 do
                            //for i:=0 to npot-1 do
                               begin
                                 if (pot[i]=don[j]) and not don[j].IsEmpty then
                                    begin
                                     if gain=0 then
                                        begin
                                           gain:=1;
                                        end
                                         else
                                          begin
                                           gain:=gain+1;
                                          end;
                                      main:=Tmain.create;
                                           main.articl:=1;
                                           main.qte:=gain;
                                           //n:=gain;
                                      card.AddOrSetValue(nblig,main);
                                    end;
                               end;
                         end;
                         total:=total+gain;
                         AddLog('nblig:'+nblig.tostring +'art:'+ card.Items[nblig].articl.ToString+ 'qte:'+card.Items[nblig].qte.ToString);
                         //limit:=limit+n;
                    except
                  end;
                until FinDeFichier;
                 AddLog('total:'+ total.ToString);
                                total:=0;
                 addlog('limit :'+limit.ToString);
                 //i:=1;
                 //repeat
                  for i:= 1  to limit do
                  begin
                       //coef.Add(1) ;
                       j:= card.Items[i].qte;
                       m:= card.Items[i].articl;
                       //n:=card.Items[i].qte;
                       if j>=1 then
                        begin
                       // k:=1;
                      //  repeat
                        for k:=i to i+j do
                             begin
                                 // coef.Add(n) ;

                                  //j:= card.Items[i].qte;
                                  //m:= card.Items[i].articl;
                                        main:=Tmain.create;
                                               main.articl:=m+1;
                                                //main.qte:=j;
                                          card.AddOrSetValue(i+k,main);
                                          main.Free;
                                   //AddLog('nblig:'+i.tostring +'art:'+ card.Items[i].articl.ToString+ 'qte:'+card.Items[i].qte.ToString);
                                   //AddLog('nblig :'+i.tostring+' coef:'+ coef.items[i].ToString);
                            // end;
                            //k:=k+1;
                       // until k=j;
                         end;
                         end;
                         AddLog('nblig:'+i.tostring +'art:'+ card.Items[i].articl.ToString+ 'qte:'+card.Items[i].qte.ToString);
                         AddLog('nblig :'+i.tostring);

                      end;
                     //i:=i+1;
                     //until i=limit;
                   total:=0;
                            for j:=1 to limit do
                              begin
                                 total:=total + card.Items[j].articl;
                                AddLog('total:'+ total.ToString);
                                card.Free;
                                main.Free;
                                end;
                      result:=total;
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  // Lecture des données et remplissage
  ListeCartes := TJ4_ListeDeCartes.Create;
  try
    PremiereLigneTraitee := false;
    repeat
      if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if PremiereLigneTraitee then
        begin // charge les cartes de jeu
          if Ligne.IsEmpty then
          begin
            NumLig := 0;
            Board := TJ4_Carte.Create;
            ListeCartes.Add(Board);
          end
          else
          begin // Charge première ligne = numéros tirés
//            Ligne := Ligne.Replace('  ', ' ');
//            var
//            Tab := Ligne.Split([' ']);
//            if (Length(Tab) <> 5) then
//              raise exception.Create('erreur : ' + Ligne);
//            for numCol := 0 to 4 do
//              Board.Numero(numCol + 1, NumLig + 1, Tab[numCol].Trim.ToInteger);
//            inc(NumLig);
          end;
        end
        else
        begin // première ligne = numeros tirés
          PremiereLigneTraitee := true;
          sListeNumeros := Ligne;
        end;
      except
      end;
    until FinDeFichier;
    FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
    // Tirage des numéros
    DerniereGrilleGagnante := nil;
//    var
//    Tab := sListeNumeros.Split([',']);
//    var
//    FinTirage := false;
//    for i := 0 to Length(Tab) - 1 do
//    begin
//      NumeroTire := Tab[i].Trim.ToInteger;
//      if (ListeCartes.Count > 0) then
//        for Board in ListeCartes do
//          if (not Board.FGagnante) and Board.isGrilleGagnanteAvecNumero
//            (NumeroTire) then
//          begin
//            DernierNumeroTire := NumeroTire;
//            DerniereGrilleGagnante := Board;
//          end;
//    end;
    if DerniereGrilleGagnante <> nil then
      AfficheResultat(Cjour, CExercice, DernierNumeroTire *
        DerniereGrilleGagnante.TotalNumerosNonTires);
  finally
    ListeCartes.Free;
  end;
end;
// Types utilisés pour le Jour 5
type
  TJ5_Y = TDictionary<integer, integer>; // Y en clé, nb en valeur
  TJ5_X = class(TObjectDictionary<integer, TJ5_Y>) // X en clé, (Y,nb) en valeur
  public
    procedure incremente(x, y: integer);
    function getValeur(x, y: integer): integer;
  end;
procedure TFadventofcod.Jour05_1;
Const
  CNumeroFichier = '09'; // 2 chiffres, en alpha
  CJour = 5; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  Ligne: string;
  Reponse: uint64;
  Map: TJ5_X;
  RegMatch: TMatchCollection;
  Valeur_Ligne: word;
  Total : int64;
  x1, y1, x2, y2: integer;
  x, y: integer;

begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                // FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
// lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  Map := TJ5_X.Create;
  try
    repeat
      if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if not Ligne.IsEmpty then
        begin // /([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)/gm
          RegMatch := tregex.matches(Ligne,
            '^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$');
          if (RegMatch.Count = 1) and (RegMatch[0].groups.Count = 5) then
          begin
            x1 := RegMatch[0].groups[1].Value.ToInteger;
            y1 := RegMatch[0].groups[2].Value.ToInteger;
            x2 := RegMatch[0].groups[3].Value.ToInteger;
            y2 := RegMatch[0].groups[4].Value.ToInteger;
            if (x1 = x2) or (y1 = y2) then
            begin
              if (x1 < x2) then
              begin
                for x := x1 to x2 do
                  if (y1 < y2) then
                    for y := y1 to y2 do
                      Map.incremente(x, y)
                  else
                    for y := y1 downto y2 do
                      Map.incremente(x, y);
              end
              else
              begin
                for x := x1 downto x2 do
                  if (y1 < y2) then
                    for y := y1 to y2 do
                      Map.incremente(x, y)
                  else
                    for y := y1 downto y2 do
                      Map.incremente(x, y);
              end;
            end;
          end;
          // x1 := tregex.Replace(Ligne,
          // '^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$', '$1').ToInteger;
          // y1 := tregex.Replace(Ligne,
          // '^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$', '$2').ToInteger;
          // x2 := tregex.Replace(Ligne,
          // '^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$', '$3').ToInteger;
          // y2 := tregex.Replace(Ligne,
          // '^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$', '$4').ToInteger;
        end;
      except
      end;
    until FinDeFichier;
    FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
//    for x in Map.keys do
//      for y in Map.items[x].keys do
//        if (Map.getValeur(x, y) > 1) then
//          Reponse := Reponse + 1;
    //AfficheResultat(CJour, CExercice, Reponse);
  finally
    Map.Free;
  end;
end;
procedure TFadventofcod.Jour05_2;
Const
  CNumeroFichier = '10'; // 2 chiffres, en alpha
  CJour = 5; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  Ligne: string;
  Reponse: uint64;
  Map: TJ5_X;
  RegMatch: TMatchCollection;
  Valeur_Ligne: word;
  Total : int64;
  x1, y1, x2, y2: integer;
  x, y: integer;
  ix, iy: integer;

begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  Map := TJ5_X.Create;
  try
    repeat
      if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if not Ligne.IsEmpty then
        begin // /([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)/gm
          RegMatch := tregex.matches(Ligne,
            '^([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)$');
          if (RegMatch.Count = 1) and (RegMatch[0].groups.Count = 5) then
          begin
            x1 := RegMatch[0].groups[1].Value.ToInteger;
            y1 := RegMatch[0].groups[2].Value.ToInteger;
            x2 := RegMatch[0].groups[3].Value.ToInteger;
            y2 := RegMatch[0].groups[4].Value.ToInteger;
            if (x1 = x2) or (y1 = y2) then
            begin
              if (x1 < x2) then
              begin
                for x := x1 to x2 do
                  if (y1 < y2) then
                    for y := y1 to y2 do
                      Map.incremente(x, y)
                  else
                    for y := y1 downto y2 do
                      Map.incremente(x, y);
              end
              else
              begin
                for x := x1 downto x2 do
                  if (y1 < y2) then
                    for y := y1 to y2 do
                      Map.incremente(x, y)
                  else
                    for y := y1 downto y2 do
                      Map.incremente(x, y);
              end;
            end
            else
            begin
              if (abs(x1 - x2) = abs(y1 - y2)) then
              begin
                if x1 > x2 then
                  ix := -1
                else if x1 < x2 then
                  ix := +1
                else
                  ix := 0;
                if y1 > y2 then
                  iy := -1
                else if y1 < y2 then
                  iy := 1
                else
                  iy := 0;
                x := x1;
                y := y1;
                repeat
                  Map.incremente(x, y);
                  x := x + ix;
                  y := y + iy;
                until (x = x2 + ix) and (y = y2 + iy);
              end;
            end;
          end;
        end;
      except
      end;
    until FinDeFichier;
    //FermeFichier;
    // Dump sur jeu de test
    // var
    // s: string := '';
    // for y := 0 to 9 do
    // begin
    // s := '';
    // for x := 0 to 9 do
    // s := s + Map.getValeur(x, y).ToString + ' ';
    // Memo1.Lines.Add(s);
    // end;
    Reponse := 0;
//    for x in Map.keys do
//      for y in Map.items[x].keys do
//        if (Map.getValeur(x, y) > 1) then
//          Reponse := Reponse + 1;
    FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
  finally
    Map.Free;
  end;
end;
procedure TFadventofcod.Jour06_1;
Const
  CNumeroFichier = '11'; // 2 chiffres, en alpha
  CJour = 6; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
  Valeur_Ligne: word;
  Total : int64;
  poissons: tlist<integer>;
  Jour: integer;
  nb: integer;
  i: integer;

begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
        2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  poissons := tlist<integer>.Create;
  try
    PremiereLigneTraitee := false;
    repeat
     if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
//      try
//        if (not PremiereLigneTraitee) and (not Ligne.IsEmpty) then
//        begin
//          PremiereLigneTraitee := true;
//          var
//          Tab := Ligne.Split([',']);
//          for i := 0 to Length(Tab) - 1 do
//            poissons.Add(Tab[i].ToInteger);
//        end;
//      except
//      end;
    until FinDeFichier;
    FermeFichier;
    // var nouveau:integer:=0;
    for Jour := 1 to 80 do
    begin
      nb := poissons.Count;
      for i := 0 to nb - 1 do
      begin
        if poissons[i] = 0 then
        begin
          poissons.Add(8);
          // inc(nouveau);
          poissons[i] := 6;
        end
        else
          poissons[i] := poissons[i] - 1;
      end;
    end;
    Reponse := poissons.Count;
    FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
    AfficheResultat(CJour, CExercice, Reponse);
  finally
    poissons.Free;
  end;
end;
procedure TFadventofcod.Jour06_2;
Const
  CNumeroFichier = '12'; // 2 chiffres, en alpha
  CJour = 6; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Valeur_Ligne: word;
  Total : int64;
  Reponse: uint64;
  NbPoissonsParJourDeGestation: TDictionary<byte, uint64>;
  nb: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
        2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  NbPoissonsParJourDeGestation := TDictionary<byte, uint64>.Create;
  try
//    for var i := 0 to 8 do
//      NbPoissonsParJourDeGestation.Add(i, 0);
//    PremiereLigneTraitee := false;
//    repeat
//      Ligne := getLigne('input-' + CNumeroFichier + '.txt');
//      try
//        if (not PremiereLigneTraitee) and (not Ligne.IsEmpty) then
//        begin
//          PremiereLigneTraitee := true;
//          var
//          Tab := Ligne.Split([',']);
//          for var i := 0 to Length(Tab) - 1 do
//            NbPoissonsParJourDeGestation[Tab[i].ToInteger] :=
//              NbPoissonsParJourDeGestation[Tab[i].ToInteger] + 1;
//        end;
//      except
//      end;
//    until FinDeFichier;
    FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
//    for var Jour := 1 to 256 do
//    begin
//      nb := NbPoissonsParJourDeGestation[0];
//      for var i := 0 to 7 do
//        NbPoissonsParJourDeGestation[i] := NbPoissonsParJourDeGestation[i + 1];
//      NbPoissonsParJourDeGestation[8] := nb;
//      NbPoissonsParJourDeGestation[6] := NbPoissonsParJourDeGestation[6] + nb;
//    end;
//    Reponse := 0;
//    for var i := 0 to 8 do
//      Reponse := Reponse + NbPoissonsParJourDeGestation[i];
    //AfficheResultat(CJour, CExercice, Reponse);
  finally
    NbPoissonsParJourDeGestation.Free;
  end;
end;
procedure TFadventofcod.Jour07_1;
Const
  CNumeroFichier = '13'; // 2 chiffres, en alpha
  CJour = 7; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Valeur_Ligne: word;
  Total : int64;
  Reponse: uint64;
  CrabPos: TDictionary<int64, int64>;
  // Dictionnaire de nombre de crabes par profondeur
  FuelMin: int64;
  posminval, posmaxval: int64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  CrabPos := TDictionary<int64, int64>.Create;
  try
    posminval := high(int64);
    posmaxval := low(int64);
    PremiereLigneTraitee := false;
    repeat
      if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if not PremiereLigneTraitee then
        begin
          PremiereLigneTraitee := true;
//          var
//          Tab := Ligne.Split([',']);
//          for var i := 0 to Length(Tab) - 1 do
//          begin
//            var
//              Profondeur: int64 := Tab[i].ToInteger;
//            if CrabPos.ContainsKey(Profondeur) then
//              CrabPos[Profondeur] := CrabPos[Profondeur] + 1
//            else
//              CrabPos.Add(Profondeur, 1);
//            if Profondeur > posmaxval then
//              posmaxval := Profondeur;
//            if Profondeur < posminval then
//              posminval := Profondeur;
//          end;
        end;
      except
      end;
    until FinDeFichier;
    FermeFichier;
    FuelMin := high(int64);
//    for var i := posminval to posmaxval do
//    begin
//      var
//        fuel: int64 := 0;
//      for var j in CrabPos.keys do
//        fuel := fuel + abs(j - i) * CrabPos[j];
//      // différence entre profondeur qu'on regarde et celle de l'élément fois le nombre de crabes à cette profondeur
//      if fuel < FuelMin then
//        FuelMin := fuel;
//    end;
    Reponse := FuelMin;
    Result:=Reponse;
    //AfficheResultat(CJour, CExercice, Reponse);
  finally
    CrabPos.Free;
  end;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour07_2;
Const
  CNumeroFichier = '14'; // 2 chiffres, en alpha
  CJour = 7; // Numéro du jour
  CExercice = 2; // Numéro exercice
  function ToCrabFuel(Profondeur: int64): int64;
  begin
    result := 0;
//    for var i := 1 to Profondeur do
//      inc(result, i);
  end;
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Valeur_Ligne: word;
  Total : int64;
  Reponse: uint64;
  CrabPos: TDictionary<int64, int64>;
  // Dictionnaire de nombre de crabes par profondeur
  FuelMin: int64;
  posminval, posmaxval: int64;
begin
  tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  CrabPos := TDictionary<int64, int64>.Create;
  try
    posminval := high(int64);
    posmaxval := low(int64);
    PremiereLigneTraitee := false;
    repeat
      if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if not PremiereLigneTraitee then
        begin
          PremiereLigneTraitee := true;
          //var
//          Tab := Ligne.Split([',']);
//          for var i := 0 to Length(Tab) - 1 do
//          begin
//            var
//              Profondeur: int64 := Tab[i].ToInteger;
//            if CrabPos.ContainsKey(Profondeur) then
//              CrabPos[Profondeur] := CrabPos[Profondeur] + 1
//            else
//              CrabPos.Add(Profondeur, 1);
//            if Profondeur > posmaxval then
//              posmaxval := Profondeur;
//            if Profondeur < posminval then
//              posminval := Profondeur;
//          end;
        end;
      except
      end;
    until FinDeFichier;
    FermeFichier;
    FuelMin := high(int64);
//    for var i := posminval to posmaxval do
//    begin
//      var
//        fuel: int64 := 0;
//      for var j in CrabPos.keys do
//        fuel := fuel + ToCrabFuel(abs(j - i)) * CrabPos[j];
//      // différence entre profondeur qu'on regarde et celle de l'élément fois le nombre de crabes à cette profondeur
//      if fuel < FuelMin then
//        FuelMin := fuel;
//    end;
    Result := FuelMin;
    //AfficheResultat(CJour, CExercice, Reponse);
  finally
    CrabPos.Free;
  end;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour08_1;
Const
  CNumeroFichier = '15'; // 2 chiffres, en alpha
  CJour = 8; // Numéro du jour
  CExercice = 1; // Numéro exercice
  function trier(s: string): string;
  var
    Tab: tstringlist;
  begin
    //Tab := tstringlist.Create;
//    try
//      for var i := 0 to 6 do
//        if i < s.Length then
//          Tab.Add(s.Chars[i]);
//      Tab.Sort;
//      result := '';
//      for var i := 0 to Tab.Count - 1 do
//        if Tab[i].Length > 0 then
//          result := result + Tab[i];
//    finally
//      Tab.Free;
//    end;
  end;
var
  Ligne: string;
  Valeur_Ligne: word;
  Total : int64;
  Reponse: uint64;
 // Chiffres: array [0 .. 9] of string;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
  Reponse := 0;
   case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
//    try
//      if not Ligne.IsEmpty then
//      begin
////        var
////        Tab := Ligne.Split([' ']);
////        if Length(Tab) = 15 then // 10 chiffres, le séparateur, 10 chiffres
////        begin
////          for var i := 0 to 9 do
////          begin
////            if Length(Tab[i]) = 2 then // 2 segments => chiffre 1
////              Chiffres[1] := trier(Tab[i])
////            else if Length(Tab[i]) = 4 then // 4 segments => chiffre 4
////              Chiffres[4] := trier(Tab[i])
////            else if Length(Tab[i]) = 3 then // 3 segments => chiffre 7
////              Chiffres[7] := trier(Tab[i])
////            else if Length(Tab[i]) = 7 then // 7 segments => chiffre 8
////              Chiffres[8] := trier(Tab[i]);
////          end;
////          for var i := 11 to 14 do
////          begin
////            if (Chiffres[1] = trier(Tab[i])) then
////              inc(Reponse)
////            else if (Chiffres[4] = trier(Tab[i])) then
////              inc(Reponse)
////            else if (Chiffres[7] = trier(Tab[i])) then
////              inc(Reponse)
////            else if (Chiffres[8] = trier(Tab[i])) then
////              inc(Reponse);
////          end;
//        end;
//      end;
//    except
//    end;
  until FinDeFichier;
 FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour08_2;
Const
  CNumeroFichier = '16'; // 2 chiffres, en alpha
  CJour = 8; // Numéro du jour
  CExercice = 2; // Numéro exercice
  function trier(s: string): string;
  var
    Tab: tstringlist;
  begin
    //Tab := tstringlist.Create;
//    try
//      for var i := 0 to s.Length - 1 do
//        if (Tab.IndexOf(s.Chars[i]) = -1) then
//          Tab.Add(s.Chars[i]);
//      Tab.Sort;
//      result := '';
//      for var i := 0 to Tab.Count - 1 do
//        if Tab[i].Length > 0 then
//          result := result + Tab[i];
//    finally
//      Tab.Free;
//    end;
  end;
var
  Ligne: string;
  Valeur_Ligne: word;
  Total : int64;
  Reponse: uint64;
  //Chiffres: array [0 .. 9] of string;
  //i: integer;
  // k: integer;
  //nombre: uint64;
  //valeur: string;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  Reponse := 0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
//    try
//      if not Ligne.IsEmpty then
//      begin
//        var
//        Tab := Ligne.Split([' ']);
//        if Length(Tab) = 15 then // 10 chiffres, le séparateur, 10 chiffres
//        begin
//          var
//          Liste235 := tstringlist.Create;
//          var
//          Liste069 := tstringlist.Create;
////          try
////            // Récupération des chiffres à nombre de segment unique
////            for i := 0 to 9 do
////            begin
////              if Length(Tab[i]) = 2 then // 2 segments => chiffre 1
////                Chiffres[1] := trier(Tab[i])
////              else if Length(Tab[i]) = 3 then // 3 segments => chiffre 7
////                Chiffres[7] := trier(Tab[i])
////              else if Length(Tab[i]) = 4 then // 4 segments => chiffre 4
////                Chiffres[4] := trier(Tab[i])
////              else if Length(Tab[i]) = 5 then
////                // 5 segments => chiffres 2, 3 ou 5
////                Liste235.Add(trier(Tab[i]))
////              else if Length(Tab[i]) = 6 then
////                // 6 segments => chiffres 0, 6 ou 9
////                Liste069.Add(trier(Tab[i]))
////              else if Length(Tab[i]) = 7 then // 7 segments => chiffre 8
////                Chiffres[8] := trier(Tab[i]);
////            end;
////            // On récupère l'angle du 4 en lui enlevant les segment communs avec le 1
////            var
////              Chiffre4Ampute: string := '';
////            for i := 0 to 3 do
////              if Chiffres[1].IndexOf(Chiffres[4].Chars[i]) = -1 then
////                Chiffre4Ampute := Chiffre4Ampute + Chiffres[4].Chars[i];
////            // traitement des chiffres à 5 segments : 2, 3, 5
////            for i := 0 to Liste235.Count - 1 do
////            begin
////              // recherche du 3 => celui qui a les deux lettres du 1
////              if (Liste235[i].IndexOf(Chiffres[1].Chars[0]) > -1) and
////                (Liste235[i].IndexOf(Chiffres[1].Chars[1]) > -1) then
////                Chiffres[3] := Liste235[i]
////                // recherche du 5 => celui qui a les mêmes deux lettres que le 4 si on lui enlève celles du 1
////              else if (Liste235[i].IndexOf(Chiffre4Ampute.Chars[0]) > -1) and
////                (Liste235[i].IndexOf(Chiffre4Ampute.Chars[1]) > -1) then
////                Chiffres[5] := Liste235[i]
////              else
////                Chiffres[2] := Liste235[i];
////            end;
////            // Le 9 c'est un 5 avec les 2 segments du 1
////            Chiffres[9] := trier(Chiffres[5] + Chiffres[1]);
////            // traitement des chiffres à 6 segments : 0, 6, 9
////            for i := 0 to Liste069.Count - 1 do
////            begin
////              // recherche du 6 => un seul segment commun avec le 1
////              if (Liste069[i].IndexOf(Chiffres[1].Chars[0]) = -1) or
////                (Liste069[i].IndexOf(Chiffres[1].Chars[1]) = -1) then
////                Chiffres[6] := Liste069[i]
////                // recherche du 0 => c'est celui qui n'est pas 9
////              else if (Chiffres[9] <> Liste069[i]) then
////                Chiffres[0] := Liste069[i];
////            end;
////          finally
////            Liste069.Free;
////            Liste235.Free;
////          end;
//          nombre := 0;
//          for i := 11 to 14 do
//          begin
//            valeur := trier(Tab[i]);
//            for k := 0 to 9 do
//              if Chiffres[k] = valeur then
//              begin
//                nombre := nombre * 10 + k;
//                break;
//              end;
//          end;
////          Memo1.Lines.Add(Ligne);
////          Memo1.Lines.Add(nombre.ToString);
//          Reponse := Reponse + nombre;
//        end
//        else
//          raise exception.Create('ligne à plus de 15 : ' + Ligne);
//      end;
//    except
//    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour09_1;
Const
  CNumeroFichier = '17';
  // 2 chiffres, en alpha
  CJour = 9; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';

     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
//  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
 FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour09_2;
Const
  CNumeroFichier = '18';
  // 2 chiffres, en alpha
  CJour = 9; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour10_1;
Const
  CNumeroFichier = '19';
  // 2 chiffres, en alpha
  CJour = 10; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour10_2;
Const
  CNumeroFichier = '20';
  // 2 chiffres, en alpha
  CJour = 10; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour11_1;
Const
  CNumeroFichier = '21';
  // 2 chiffres, en alpha
  CJour = 11; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
// lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
 FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour11_2;
Const
  CNumeroFichier = '22';
  // 2 chiffres, en alpha
  CJour = 11; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
// lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour12_1;
Const
  CNumeroFichier = '23';
  // 2 chiffres, en alpha
  CJour = 12; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour12_2;
Const
  CNumeroFichier = '24';
  // 2 chiffres, en alpha
  CJour = 12; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour13_1;
Const
  CNumeroFichier = '25';
  // 2 chiffres, en alpha
  CJour = 13; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour13_2;
Const
  CNumeroFichier = '26';
  // 2 chiffres, en alpha
  CJour = 13; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour14_1;
Const
  CNumeroFichier = '27';
  // 2 chiffres, en alpha
  CJour = 14; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                 if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour14_2;
Const
  CNumeroFichier = '28';
  // 2 chiffres, en alpha
  CJour = 14; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour15_1;
Const
  CNumeroFichier = '29';
  // 2 chiffres, en alpha
  CJour = 15; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
  tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour15_2;
Const
  CNumeroFichier = '30';
  // 2 chiffres, en alpha
  CJour = 15; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
    if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                 if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour16_1;
Const
  CNumeroFichier = '31';
  // 2 chiffres, en alpha
  CJour = 16; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
        2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
// lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour16_2;
Const
  CNumeroFichier = '32';
  // 2 chiffres, en alpha
  CJour = 16; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                // FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour17_1;
Const
  CNumeroFichier = '33';
  // 2 chiffres, en alpha
  CJour = 17; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin
                nblig:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                  inc(nblig);
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
 FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour17_2;
Const
  CNumeroFichier = '34';
  // 2 chiffres, en alpha
  CJour = 17; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
// lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour18_1;
Const
  CNumeroFichier = '35';
  // 2 chiffres, en alpha
  CJour = 18; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
        2023:
            begin

                repeat
                 if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin
                nblig:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                  inc(nblig);
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour18_2;
Const
  CNumeroFichier = '36';
  // 2 chiffres, en alpha
  CJour = 18; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
 FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour19_1;
Const
  CNumeroFichier = '37';
  // 2 chiffres, en alpha
  CJour = 19; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour19_2;
Const
  CNumeroFichier = '38';
  // 2 chiffres, en alpha
  CJour = 19; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
        2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
 FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour20_1;
Const
  CNumeroFichier = '39';
  // 2 chiffres, en alpha
  CJour = 20; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour20_2;
Const
  CNumeroFichier = '40';
  // 2 chiffres, en alpha
  CJour = 20; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
// lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour21_1;
Const
  CNumeroFichier = '41';
  // 2 chiffres, en alpha
  CJour = 21; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
 FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour21_2;
Const
  CNumeroFichier = '42';
  // 2 chiffres, en alpha
  CJour = 21; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour22_1;
Const
  CNumeroFichier = '43';
  // 2 chiffres, en alpha
  CJour = 22; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
    if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour22_2;
Const
  CNumeroFichier = '44';
  // 2 chiffres, en alpha
  CJour = 22; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour23_1;
Const
  CNumeroFichier = '45';
  // 2 chiffres, en alpha
  CJour = 23; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
    if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour23_2;
Const
  CNumeroFichier = '46';
  // 2 chiffres, en alpha
  CJour = 23; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                 if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour24_1;
Const
  CNumeroFichier = '47';
  // 2 chiffres, en alpha
  CJour = 24; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
// lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour24_2;
Const
  CNumeroFichier = '48';
  // 2 chiffres, en alpha
  CJour = 24; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
     if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour25_1;
Const
  CNumeroFichier = '49';
  // 2 chiffres, en alpha
  CJour = 25; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  nblig:int64;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
    if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin
                nblig:=0;
                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                     Tab := Ligne.Split([':']);
                     nblig:=nblig+1;
                    Valeur_Ligne := Ligne.ToInteger;
                    //MessageDlg(Tab[0],mtError,mbOKCancel,0) ;
                     //MessageDlg(Tab[0],mtError,mbOKCancel,0) ;
                  except
                  end;
                  MessageDlg(Tab[0],mtError,mbOKCancel,0) ;
                until FinDeFichier;
                result:=nblig;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                // AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
// lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.Jour25_2;
Const
  CNumeroFichier = '50';
  // 2 chiffres, en alpha
  CJour = 25; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
    tim.Start;
    lbProc.Caption:= 'Début du traitement.Ouverture du fichier...';
    if cbTest.Checked=true then
  VisuFic('input-t' + CNumeroFichier + '.txt')
  else
    VisuFic('input-' + CNumeroFichier + '.txt');
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
//  lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
procedure TFadventofcod.OuvreFichier(NomFichier: string);
begin
  FermeFichier;
  assignfile(Fichier, NomFichier);
  reset(Fichier);
  FichierOuvert := NomFichier;
end;
procedure TFadventofcod.TemplateJour;
Const
  CNumeroFichier = '05';
  // 2 chiffres, en alpha
  CJour = 5; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Total : int64;
  Ligne: string;
  Reponse: uint64;
begin
      case Annee.ToInteger of
       2021 :
           begin
           end;
       2022 :
            begin
             MessageDlg('code a venir',mtError,mbOKCancel,0) ;
            end;
       2023:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2024:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
         2025:
            begin

                repeat
                  if cbTest.Checked=true then
                  Ligne := getLigne('input-t' + CNumeroFichier + '.txt')
                  else
                  Ligne := getLigne('input-' + CNumeroFichier + '.txt');
                  try
                    Valeur_Ligne := Ligne.ToInteger;

                  except
                  end;
                until FinDeFichier;
                 //FermeFichier;
                 //AfficheResultat(Cjour, CExercice, Total);
            end;
   else
       MessageDlg('Aucune année sélectionnée',mtError,mbOKCancel,0) ;
  end;
//  FermeFichier;
// lbproc.Caption:='Fin du traitement...';
//  AfficheResultat(Cjour, CExercice,Result );
//  lbproc.Caption:='Affichage du résultat...';
//   tim.Stop;
//    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
//   log:=nblig;
//   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
//  AfficheLog(CJour,CExercice,Log,Tps);
  PremiereLigneTraitee := false;
  Reponse:=0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if PremiereLigneTraitee then
      begin
      end
      else
      begin
        PremiereLigneTraitee := true;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  lbproc.Caption:='Fin du traitement...';
  AfficheResultat(Cjour, CExercice,Result );
  lbproc.Caption:='Affichage du résultat...';
   tim.Stop;
    lbTime.Caption:=Mstotimestring(tim.ElapsedMilliseconds);
   log:=nblig;
   Tps:=Mstotimestring(tim.ElapsedMilliseconds);
  AfficheLog(CJour,CExercice,Log,Tps);
end;
{ TJ4_Carte }
constructor TJ4_Carte.Create;
var
  col, lig: integer;
begin
  for col := 1 to 5 do
    for lig := 1 to 5 do
      FGrille[col, lig] := nil;
  FGagnante := false;
end;
procedure TJ4_Carte.Numero(ACol, ALig, ANumero: integer);
begin
  if (ACol in [1 .. 5]) and (ALig in [1 .. 5]) then
  begin
    if (FGrille[ACol, ALig] = nil) then
      FGrille[ACol, ALig] := TJ4_Case.Create(ANumero)
    else
    begin
      FGrille[ACol, ALig].FNumero := ANumero;
      FGrille[ACol, ALig].FTire := false;
    end;
  end
  else
    raise exception.Create('Pas dans la grille');
end;
destructor TJ4_Carte.Destroy;
var
  col, lig: integer;
begin
  for col := 1 to 5 do
    for lig := 1 to 5 do
      if (FGrille[col, lig] <> nil) then
        FGrille[col, lig].Free;
  inherited;
end;
function TJ4_Carte.isColonneFinie(ACol: integer): boolean;
var
  lig: integer;
begin
  result := false;
  if (ACol in [1 .. 5]) then
  begin
    result := true;
    for lig := 1 to 5 do
      result := result and (FGrille[ACol, lig] <> nil) and
        FGrille[ACol, lig].FTire;
  end;
end;
function TJ4_Carte.isGrilleGagnanteAvecNumero(ANumero: integer): boolean;
var
  col, lig: integer;
begin
  result := false;
  for col := 1 to 5 do
    for lig := 1 to 5 do
      if (FGrille[col, lig] <> nil) and (FGrille[col, lig].FNumero = ANumero)
      then
      begin
        FGrille[col, lig].FTire := true;
        if isLigneFinie(lig) or isColonneFinie(col) then
        begin
          result := true;
          FGagnante := true;
          exit;
        end;
      end;
end;
function TJ4_Carte.isLigneFinie(ALig: integer): boolean;
var
  col: integer;
begin
  result := false;
  if (ALig in [1 .. 5]) then
  begin
    result := true;
    for col := 1 to 5 do
      result := result and (FGrille[col, ALig] <> nil) and
        FGrille[col, ALig].FTire;
  end;
end;
function TJ4_Carte.Numero(ACol, ALig: integer): integer;
begin
  if (ACol in [1 .. 5]) and (ALig in [1 .. 5]) and (FGrille[ACol, ALig] <> nil)
  then
    result := FGrille[ACol, ALig].FNumero
  else
    raise exception.Create('Pas dans la grille ou pas de case');
end;
function TJ4_Carte.TotalNumerosNonTires: integer;
var
  col, lig: integer;
begin
  result := 0;
  for col := 1 to 5 do
    for lig := 1 to 5 do
      if (FGrille[col, lig] <> nil) and (not FGrille[col, lig].FTire) then
        result := result + FGrille[col, lig].FNumero;
end;
{ TJ4_Case }
constructor TJ4_Case.Create(ANumero: integer);
begin
  FNumero := ANumero;
  FTire := false;
end;
{ TJ5_X }
function TJ5_X.getValeur(x, y: integer): integer;
begin
  if ContainsKey(x) and items[x].ContainsKey(y) then
    result := items[x].items[y]
  else
    result := 0;
end;
procedure TJ5_X.incremente(x, y: integer);
begin
  if not ContainsKey(x) then
    Add(x, TJ5_Y.Create);
  if not items[x].ContainsKey(y) then
    items[x].Add(y, 0);
  items[x].items[y] := items[x].items[y] + 1;
end;
  function TFadventofcod.MsToTimeString(ms: int64): string ;
   var
    dt: TDatetime;
    S: string;
  begin
    dt := 0;
    dt.addMilliSecond(ms);
    S := dt.GetMilliSecond.tostring;
    while length(S) < 3 do
      S := '0' + S;
    result := TimeToStr(dt) + ',' + S;
 end;
procedure TFadventofcod.BeginTraitement;
begin
  //Button1.Enabled := false;
  //Button2.Enabled := false;
  ActivityIndicator1.animate := true;
end;
procedure TFadventofcod.EndTraitement;
begin
  tthread.Queue(nil,
    procedure
    begin
      ActivityIndicator1.animate := false;
      //Button1.Enabled := true;
      //Button2.Enabled := true;
    end);
end;
procedure TFadventofcod.AddLog(const S: String);
begin
  tthread.Synchronize(nil,
    procedure
    begin
      Memo3.Lines.Add(S);
    end);
end;
end.
