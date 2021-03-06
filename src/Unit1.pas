unit Unit1;
interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.Rtti,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs;
type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    CbJour: TComboBox;
    CbExo: TComboBox;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure CbExoClick(Sender: TObject);


    procedure FormCreate(Sender: TObject);

  private
    { Déclarations privées }
    FichierOuvert: string;
    Fichier: Text;
    Chemin: String;
    function getLigne(NomFichier: string): string;
    function FinDeFichier: boolean;
    procedure FermeFichier;
    procedure OuvreFichier(NomFichier: string);
    procedure AfficheResultat(Jour, Exercice: byte; Reponse: uint64);
    function BinToInt64(Bin: string): int64;
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
  Form1: TForm1;
implementation
{$R *.dfm}
Uses
  System.Generics.Collections, System.RegularExpressions;
procedure TForm1.AfficheResultat(Jour, Exercice: byte; Reponse: uint64);
begin
  Memo1.Lines.Add('Jour ' + Jour.ToString + ' Exercice ' + Exercice.ToString +
    ' Reponse ' + Reponse.ToString);
end;
function TForm1.BinToInt64(Bin: string): int64;
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

 procedure TForm1.CbExoClick(Sender: TObject);
var

methode:trttimethod;

begin
   Memo1.Lines.Clear;
  if (CbJour.Text<>'') and (CbExo.Text<>'') then
    begin

            methode:=TRttiContext.Create.GetType(TForm1).GetMethod('Jour'+CbJour.Text+'_'+CbExo.Text) ;
            methode.Invoke(Form1,[]);
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

procedure TForm1.FormCreate(Sender: TObject);
var
methode: TRttiMethod;
NomdeLaProcedure: string;
begin
  for methode in TRttiContext.Create.GetType(TForm1).GetMethods  do
      begin
         NomdeLaProcedure:=methode.Name;
//         if(NomdeLaProcedure.StartsWith('Jour')) then
//              begin
//
//
//              end;
      end;

end;


procedure TForm1.FermeFichier;
begin
  if not FichierOuvert.IsEmpty then
  begin
    closefile(Fichier);
    FichierOuvert := '';
  end;
end;
function TForm1.FinDeFichier: boolean;
begin
  result := (FichierOuvert = '') or eof(Fichier);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

function TForm1.getLigne(NomFichier: string): string;
begin
     Chemin:='c:\user\delphi\projets\adventofcode\data\';
     NomFichier:= Chemin + NomFichier;
      //MessageDlg(NomFichier,mtError,mbOKCancel,0) ;
  if (NomFichier <> FichierOuvert) then
    OuvreFichier(NomFichier);
  if (not FinDeFichier) then
    readln(Fichier, result);
  result := result.Trim;
end;
procedure TForm1.Jour01_1;
 Const
  CNumeroFichier = '01'; // 2 chiffres, en alpha
  CJour = 1; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Valeur_Ligne: word;
  Ligne: string;
  Valeur_Precedente: word;
  Nb_Increments: int64;
begin
  PremiereLigneTraitee := false;
  Valeur_Precedente := 0;
  Nb_Increments := 0;
  repeat
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
  AfficheResultat(1, 1, Nb_Increments);
end;
procedure TForm1.Jour01_2;
Const
  CNumeroFichier = '01'; // 2 chiffres, en alpha
  CJour = 1; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  TroisPremieresLignesTraitees: boolean;
  Valeur_Ligne: word;
  Ligne: string;
  Valeur_1, Valeur_2: word;
  Nb_Increments: int64;
  Tab_Valeurs: array [0 .. 2] of word;
  Num_Ligne: int64;
begin
  TroisPremieresLignesTraitees := false;
  Valeur_1 := 0;
  Valeur_2 := 0;
  Nb_Increments := 0;
  Num_Ligne := 0;
  Tab_Valeurs[0] := 0;
  Tab_Valeurs[1] := 0;
  Tab_Valeurs[2] := 0;
  repeat
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
  AfficheResultat(1, 1, Nb_Increments);
end;
procedure TForm1.Jour02_1;
Const
  CNumeroFichier = '02'; // 2 chiffres, en alpha
  CJour = 2; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  Ligne: string;
  Valeur_Ligne: word;
  Tab: tarray<string>;
  Operation: string;
  Profondeur: int64;
  DistanceParcourrue: int64;
begin
  Profondeur := 0;
  DistanceParcourrue := 0;
  repeat
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
  FermeFichier;
  AfficheResultat(2, 1, Profondeur * DistanceParcourrue);
end;
procedure TForm1.Jour02_2;
Const
  CNumeroFichier = '02'; // 2 chiffres, en alpha
  CJour = 2; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  Ligne: string;
  Valeur_Ligne: word;
  Tab: tarray<string>;
  Operation: string;
  Profondeur: int64;
  Objectif: int64;
  DistanceParcourrue: int64;
begin
  Profondeur := 0;
  Objectif := 0;
  DistanceParcourrue := 0;
  repeat
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
  FermeFichier;
  AfficheResultat(2, 2, Profondeur * DistanceParcourrue);
end;
procedure TForm1.Jour03_1;
type
  TTabBin = array [0 .. 1] of int64;
Const
  CNumeroFichier = '03'; // 2 chiffres, en alpha
  CJour = 3; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  Ligne: string;
  GammaRate: integer;
  // composé par les bits les plus présents dans chaque colonne du fichier
  EpsilonRate: integer;
  // composé par les bits les moins présents dans chaque colonne du fichier
  Tab: array of TTabBin; // Nombre d'occurrence de 0/1 par colonne
  PremiereLigne: boolean;
  i: integer;
begin
  PremiereLigne := true;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    if (Ligne.Length > 0) then
      try
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
  FermeFichier;
  AfficheResultat(3, 1, GammaRate * EpsilonRate);
end;
procedure TForm1.Jour03_2;
Const
  CNumeroFichier = '03'; // 2 chiffres, en alpha
  CJour = 3; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  Ligne: string;
  NumColonne, NbColonnes: byte;
  Nb0_Oxy, Nb1_Oxy: int64;
  Oxygene_Bin: string;
  Nb0_CO2, Nb1_CO2: int64;
  CO2_Bin: string;
  PremiereLigne: boolean;
begin
  PremiereLigne := true;
  NbColonnes := 0;
  NumColonne := 0;
  Oxygene_Bin := '';
  CO2_Bin := '';
  repeat
    Nb0_Oxy := 0;
    Nb1_Oxy := 0;
    Nb0_CO2 := 0;
    Nb1_CO2 := 0;
    repeat
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
  AfficheResultat(3, 2, BinToInt64(Oxygene_Bin) * BinToInt64(CO2_Bin));
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
procedure TForm1.Jour04_1;
Const
  CNumeroFichier = '04'; // 2 chiffres, en alpha
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
  i: integer;
begin
  // Lecture des données et remplissage
  ListeCartes := TJ4_ListeDeCartes.Create;
  try
    PremiereLigneTraitee := false;
    repeat
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
            Ligne := Ligne.Replace('  ', ' ');
            var
            Tab := Ligne.Split([' ']);
            if (Length(Tab) <> 5) then
              raise exception.Create('erreur : ' + Ligne);
            for numCol := 0 to 4 do
              Board.Numero(numCol + 1, NumLig + 1, Tab[numCol].Trim.ToInteger);
            inc(NumLig);
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
    // Tirage des numéros
    var
    Tab := sListeNumeros.Split([',']);
    var
    FinTirage := false;
    for i := 0 to Length(Tab) - 1 do
    begin
      NumeroTire := Tab[i].Trim.ToInteger;
      if (ListeCartes.Count > 0) then
        for Board in ListeCartes do
          if Board.isGrilleGagnanteAvecNumero(NumeroTire) then
          begin
            AfficheResultat(4, 1, NumeroTire * Board.TotalNumerosNonTires);
            FinTirage := true;
            break;
          end;
      if FinTirage then
        break;
    end;
  finally
    ListeCartes.Free;
  end;
end;
procedure TForm1.Jour04_2;
Const
  CNumeroFichier = '04'; // 2 chiffres, en alpha
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
  i: integer;
begin
  // Lecture des données et remplissage
  ListeCartes := TJ4_ListeDeCartes.Create;
  try
    PremiereLigneTraitee := false;
    repeat
      Ligne := getLigne('input-04.txt');
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
            Ligne := Ligne.Replace('  ', ' ');
            var
            Tab := Ligne.Split([' ']);
            if (Length(Tab) <> 5) then
              raise exception.Create('erreur : ' + Ligne);
            for numCol := 0 to 4 do
              Board.Numero(numCol + 1, NumLig + 1, Tab[numCol].Trim.ToInteger);
            inc(NumLig);
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
    // Tirage des numéros
    DerniereGrilleGagnante := nil;
    var
    Tab := sListeNumeros.Split([',']);
    var
    FinTirage := false;
    for i := 0 to Length(Tab) - 1 do
    begin
      NumeroTire := Tab[i].Trim.ToInteger;
      if (ListeCartes.Count > 0) then
        for Board in ListeCartes do
          if (not Board.FGagnante) and Board.isGrilleGagnanteAvecNumero
            (NumeroTire) then
          begin
            DernierNumeroTire := NumeroTire;
            DerniereGrilleGagnante := Board;
          end;
    end;
    if DerniereGrilleGagnante <> nil then
      AfficheResultat(4, 2, DernierNumeroTire *
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
procedure TForm1.Jour05_1;
Const
  CNumeroFichier = '05'; // 2 chiffres, en alpha
  CJour = 5; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  Ligne: string;
  Reponse: uint64;
  Map: TJ5_X;
  RegMatch: TMatchCollection;
  x1, y1, x2, y2: integer;
  x, y: integer;
begin
  Map := TJ5_X.Create;
  try
    repeat
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
    Reponse := 0;
    for x in Map.keys do
      for y in Map.items[x].keys do
        if (Map.getValeur(x, y) > 1) then
          Reponse := Reponse + 1;
    AfficheResultat(CJour, CExercice, Reponse);
  finally
    Map.Free;
  end;
end;
procedure TForm1.Jour05_2;
Const
  CNumeroFichier = '05'; // 2 chiffres, en alpha
  CJour = 5; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  Ligne: string;
  Reponse: uint64;
  Map: TJ5_X;
  RegMatch: TMatchCollection;
  x1, y1, x2, y2: integer;
  x, y: integer;
  ix, iy: integer;
begin
  Map := TJ5_X.Create;
  try
    repeat
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
    FermeFichier;
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
    for x in Map.keys do
      for y in Map.items[x].keys do
        if (Map.getValeur(x, y) > 1) then
          Reponse := Reponse + 1;
    AfficheResultat(CJour, CExercice, Reponse);
  finally
    Map.Free;
  end;
end;
procedure TForm1.Jour06_1;
Const
  CNumeroFichier = '06'; // 2 chiffres, en alpha
  CJour = 6; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
  poissons: tlist<integer>;
  Jour: integer;
  nb: integer;
  i: integer;
begin
  poissons := tlist<integer>.Create;
  try
    PremiereLigneTraitee := false;
    repeat
      Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if (not PremiereLigneTraitee) and (not Ligne.IsEmpty) then
        begin
          PremiereLigneTraitee := true;
          var
          Tab := Ligne.Split([',']);
          for i := 0 to Length(Tab) - 1 do
            poissons.Add(Tab[i].ToInteger);
        end;
      except
      end;
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
    AfficheResultat(CJour, CExercice, Reponse);
  finally
    poissons.Free;
  end;
end;
procedure TForm1.Jour06_2;
Const
  CNumeroFichier = '06'; // 2 chiffres, en alpha
  CJour = 6; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
  NbPoissonsParJourDeGestation: TDictionary<byte, uint64>;
  nb: uint64;
begin
  NbPoissonsParJourDeGestation := TDictionary<byte, uint64>.Create;
  try
    for var i := 0 to 8 do
      NbPoissonsParJourDeGestation.Add(i, 0);
    PremiereLigneTraitee := false;
    repeat
      Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if (not PremiereLigneTraitee) and (not Ligne.IsEmpty) then
        begin
          PremiereLigneTraitee := true;
          var
          Tab := Ligne.Split([',']);
          for var i := 0 to Length(Tab) - 1 do
            NbPoissonsParJourDeGestation[Tab[i].ToInteger] :=
              NbPoissonsParJourDeGestation[Tab[i].ToInteger] + 1;
        end;
      except
      end;
    until FinDeFichier;
    FermeFichier;
    for var Jour := 1 to 256 do
    begin
      nb := NbPoissonsParJourDeGestation[0];
      for var i := 0 to 7 do
        NbPoissonsParJourDeGestation[i] := NbPoissonsParJourDeGestation[i + 1];
      NbPoissonsParJourDeGestation[8] := nb;
      NbPoissonsParJourDeGestation[6] := NbPoissonsParJourDeGestation[6] + nb;
    end;
    Reponse := 0;
    for var i := 0 to 8 do
      Reponse := Reponse + NbPoissonsParJourDeGestation[i];
    AfficheResultat(CJour, CExercice, Reponse);
  finally
    NbPoissonsParJourDeGestation.Free;
  end;
end;
procedure TForm1.Jour07_1;
Const
  CNumeroFichier = '07'; // 2 chiffres, en alpha
  CJour = 7; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
  CrabPos: TDictionary<int64, int64>;
  // Dictionnaire de nombre de crabes par profondeur
  FuelMin: int64;
  posminval, posmaxval: int64;
begin
  CrabPos := TDictionary<int64, int64>.Create;
  try
    posminval := high(int64);
    posmaxval := low(int64);
    PremiereLigneTraitee := false;
    repeat
      Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if not PremiereLigneTraitee then
        begin
          PremiereLigneTraitee := true;
          var
          Tab := Ligne.Split([',']);
          for var i := 0 to Length(Tab) - 1 do
          begin
            var
              Profondeur: int64 := Tab[i].ToInteger;
            if CrabPos.ContainsKey(Profondeur) then
              CrabPos[Profondeur] := CrabPos[Profondeur] + 1
            else
              CrabPos.Add(Profondeur, 1);
            if Profondeur > posmaxval then
              posmaxval := Profondeur;
            if Profondeur < posminval then
              posminval := Profondeur;
          end;
        end;
      except
      end;
    until FinDeFichier;
    FermeFichier;
    FuelMin := high(int64);
    for var i := posminval to posmaxval do
    begin
      var
        fuel: int64 := 0;
      for var j in CrabPos.keys do
        fuel := fuel + abs(j - i) * CrabPos[j];
      // différence entre profondeur qu'on regarde et celle de l'élément fois le nombre de crabes à cette profondeur
      if fuel < FuelMin then
        FuelMin := fuel;
    end;
    Reponse := FuelMin;
    AfficheResultat(CJour, CExercice, Reponse);
  finally
    CrabPos.Free;
  end;
end;
procedure TForm1.Jour07_2;
Const
  CNumeroFichier = '07'; // 2 chiffres, en alpha
  CJour = 7; // Numéro du jour
  CExercice = 2; // Numéro exercice
  function ToCrabFuel(Profondeur: int64): int64;
  begin
    result := 0;
    for var i := 1 to Profondeur do
      inc(result, i);
  end;
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
  CrabPos: TDictionary<int64, int64>;
  // Dictionnaire de nombre de crabes par profondeur
  FuelMin: int64;
  posminval, posmaxval: int64;
begin
  CrabPos := TDictionary<int64, int64>.Create;
  try
    posminval := high(int64);
    posmaxval := low(int64);
    PremiereLigneTraitee := false;
    repeat
      Ligne := getLigne('input-' + CNumeroFichier + '.txt');
      try
        if not PremiereLigneTraitee then
        begin
          PremiereLigneTraitee := true;
          var
          Tab := Ligne.Split([',']);
          for var i := 0 to Length(Tab) - 1 do
          begin
            var
              Profondeur: int64 := Tab[i].ToInteger;
            if CrabPos.ContainsKey(Profondeur) then
              CrabPos[Profondeur] := CrabPos[Profondeur] + 1
            else
              CrabPos.Add(Profondeur, 1);
            if Profondeur > posmaxval then
              posmaxval := Profondeur;
            if Profondeur < posminval then
              posminval := Profondeur;
          end;
        end;
      except
      end;
    until FinDeFichier;
    FermeFichier;
    FuelMin := high(int64);
    for var i := posminval to posmaxval do
    begin
      var
        fuel: int64 := 0;
      for var j in CrabPos.keys do
        fuel := fuel + ToCrabFuel(abs(j - i)) * CrabPos[j];
      // différence entre profondeur qu'on regarde et celle de l'élément fois le nombre de crabes à cette profondeur
      if fuel < FuelMin then
        FuelMin := fuel;
    end;
    Reponse := FuelMin;
    AfficheResultat(CJour, CExercice, Reponse);
  finally
    CrabPos.Free;
  end;
end;
procedure TForm1.Jour08_1;
Const
  CNumeroFichier = '08'; // 2 chiffres, en alpha
  CJour = 8; // Numéro du jour
  CExercice = 1; // Numéro exercice
  function trier(s: string): string;
  var
    Tab: tstringlist;
  begin
    Tab := tstringlist.Create;
    try
      for var i := 0 to 6 do
        if i < s.Length then
          Tab.Add(s.Chars[i]);
      Tab.Sort;
      result := '';
      for var i := 0 to Tab.Count - 1 do
        if Tab[i].Length > 0 then
          result := result + Tab[i];
    finally
      Tab.Free;
    end;
  end;
var
  Ligne: string;
  Reponse: uint64;
  Chiffres: array [0 .. 9] of string;
begin
  Reponse := 0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if not Ligne.IsEmpty then
      begin
        var
        Tab := Ligne.Split([' ']);
        if Length(Tab) = 15 then // 10 chiffres, le séparateur, 10 chiffres
        begin
          for var i := 0 to 9 do
          begin
            if Length(Tab[i]) = 2 then // 2 segments => chiffre 1
              Chiffres[1] := trier(Tab[i])
            else if Length(Tab[i]) = 4 then // 4 segments => chiffre 4
              Chiffres[4] := trier(Tab[i])
            else if Length(Tab[i]) = 3 then // 3 segments => chiffre 7
              Chiffres[7] := trier(Tab[i])
            else if Length(Tab[i]) = 7 then // 7 segments => chiffre 8
              Chiffres[8] := trier(Tab[i]);
          end;
          for var i := 11 to 14 do
          begin
            if (Chiffres[1] = trier(Tab[i])) then
              inc(Reponse)
            else if (Chiffres[4] = trier(Tab[i])) then
              inc(Reponse)
            else if (Chiffres[7] = trier(Tab[i])) then
              inc(Reponse)
            else if (Chiffres[8] = trier(Tab[i])) then
              inc(Reponse);
          end;
        end;
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour08_2;
Const
  CNumeroFichier = '08'; // 2 chiffres, en alpha
  CJour = 8; // Numéro du jour
  CExercice = 2; // Numéro exercice
  function trier(s: string): string;
  var
    Tab: tstringlist;
  begin
    Tab := tstringlist.Create;
    try
      for var i := 0 to s.Length - 1 do
        if (Tab.IndexOf(s.Chars[i]) = -1) then
          Tab.Add(s.Chars[i]);
      Tab.Sort;
      result := '';
      for var i := 0 to Tab.Count - 1 do
        if Tab[i].Length > 0 then
          result := result + Tab[i];
    finally
      Tab.Free;
    end;
  end;
var
  Ligne: string;
  Reponse: uint64;
  Chiffres: array [0 .. 9] of string;
  i, k: integer;
  nombre: uint64;
  valeur: string;
begin
  Reponse := 0;
  repeat
    Ligne := getLigne('input-' + CNumeroFichier + '.txt');
    try
      if not Ligne.IsEmpty then
      begin
        var
        Tab := Ligne.Split([' ']);
        if Length(Tab) = 15 then // 10 chiffres, le séparateur, 10 chiffres
        begin
          var
          Liste235 := tstringlist.Create;
          var
          Liste069 := tstringlist.Create;
          try
            // Récupération des chiffres à nombre de segment unique
            for i := 0 to 9 do
            begin
              if Length(Tab[i]) = 2 then // 2 segments => chiffre 1
                Chiffres[1] := trier(Tab[i])
              else if Length(Tab[i]) = 3 then // 3 segments => chiffre 7
                Chiffres[7] := trier(Tab[i])
              else if Length(Tab[i]) = 4 then // 4 segments => chiffre 4
                Chiffres[4] := trier(Tab[i])
              else if Length(Tab[i]) = 5 then
                // 5 segments => chiffres 2, 3 ou 5
                Liste235.Add(trier(Tab[i]))
              else if Length(Tab[i]) = 6 then
                // 6 segments => chiffres 0, 6 ou 9
                Liste069.Add(trier(Tab[i]))
              else if Length(Tab[i]) = 7 then // 7 segments => chiffre 8
                Chiffres[8] := trier(Tab[i]);
            end;
            // On récupère l'angle du 4 en lui enlevant les segment communs avec le 1
            var
              Chiffre4Ampute: string := '';
            for i := 0 to 3 do
              if Chiffres[1].IndexOf(Chiffres[4].Chars[i]) = -1 then
                Chiffre4Ampute := Chiffre4Ampute + Chiffres[4].Chars[i];
            // traitement des chiffres à 5 segments : 2, 3, 5
            for i := 0 to Liste235.Count - 1 do
            begin
              // recherche du 3 => celui qui a les deux lettres du 1
              if (Liste235[i].IndexOf(Chiffres[1].Chars[0]) > -1) and
                (Liste235[i].IndexOf(Chiffres[1].Chars[1]) > -1) then
                Chiffres[3] := Liste235[i]
                // recherche du 5 => celui qui a les mêmes deux lettres que le 4 si on lui enlève celles du 1
              else if (Liste235[i].IndexOf(Chiffre4Ampute.Chars[0]) > -1) and
                (Liste235[i].IndexOf(Chiffre4Ampute.Chars[1]) > -1) then
                Chiffres[5] := Liste235[i]
              else
                Chiffres[2] := Liste235[i];
            end;
            // Le 9 c'est un 5 avec les 2 segments du 1
            Chiffres[9] := trier(Chiffres[5] + Chiffres[1]);
            // traitement des chiffres à 6 segments : 0, 6, 9
            for i := 0 to Liste069.Count - 1 do
            begin
              // recherche du 6 => un seul segment commun avec le 1
              if (Liste069[i].IndexOf(Chiffres[1].Chars[0]) = -1) or
                (Liste069[i].IndexOf(Chiffres[1].Chars[1]) = -1) then
                Chiffres[6] := Liste069[i]
                // recherche du 0 => c'est celui qui n'est pas 9
              else if (Chiffres[9] <> Liste069[i]) then
                Chiffres[0] := Liste069[i];
            end;
          finally
            Liste069.Free;
            Liste235.Free;
          end;
          nombre := 0;
          for i := 11 to 14 do
          begin
            valeur := trier(Tab[i]);
            for k := 0 to 9 do
              if Chiffres[k] = valeur then
              begin
                nombre := nombre * 10 + k;
                break;
              end;
          end;
//          Memo1.Lines.Add(Ligne);
//          Memo1.Lines.Add(nombre.ToString);
          Reponse := Reponse + nombre;
        end
        else
          raise exception.Create('ligne à plus de 15 : ' + Ligne);
      end;
    except
    end;
  until FinDeFichier;
  FermeFichier;
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour09_1;
Const
  CNumeroFichier = '09';
  // 2 chiffres, en alpha
  CJour = 9; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour09_2;
Const
  CNumeroFichier = '09';
  // 2 chiffres, en alpha
  CJour = 9; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour10_1;
Const
  CNumeroFichier = '10';
  // 2 chiffres, en alpha
  CJour = 10; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour10_2;
Const
  CNumeroFichier = '10';
  // 2 chiffres, en alpha
  CJour = 10; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour11_1;
Const
  CNumeroFichier = '11';
  // 2 chiffres, en alpha
  CJour = 11; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour11_2;
Const
  CNumeroFichier = '11';
  // 2 chiffres, en alpha
  CJour = 11; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour12_1;
Const
  CNumeroFichier = '12';
  // 2 chiffres, en alpha
  CJour = 12; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour12_2;
Const
  CNumeroFichier = '12';
  // 2 chiffres, en alpha
  CJour = 12; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour13_1;
Const
  CNumeroFichier = '13';
  // 2 chiffres, en alpha
  CJour = 13; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour13_2;
Const
  CNumeroFichier = '13';
  // 2 chiffres, en alpha
  CJour = 13; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour14_1;
Const
  CNumeroFichier = '14';
  // 2 chiffres, en alpha
  CJour = 14; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour14_2;
Const
  CNumeroFichier = '14';
  // 2 chiffres, en alpha
  CJour = 14; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour15_1;
Const
  CNumeroFichier = '15';
  // 2 chiffres, en alpha
  CJour = 15; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour15_2;
Const
  CNumeroFichier = '15';
  // 2 chiffres, en alpha
  CJour = 15; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour16_1;
Const
  CNumeroFichier = '16';
  // 2 chiffres, en alpha
  CJour = 16; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour16_2;
Const
  CNumeroFichier = '16';
  // 2 chiffres, en alpha
  CJour = 16; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour17_1;
Const
  CNumeroFichier = '17';
  // 2 chiffres, en alpha
  CJour = 17; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour17_2;
Const
  CNumeroFichier = '17';
  // 2 chiffres, en alpha
  CJour = 17; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour18_1;
Const
  CNumeroFichier = '18';
  // 2 chiffres, en alpha
  CJour = 18; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour18_2;
Const
  CNumeroFichier = '18';
  // 2 chiffres, en alpha
  CJour = 18; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour19_1;
Const
  CNumeroFichier = '19';
  // 2 chiffres, en alpha
  CJour = 19; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour19_2;
Const
  CNumeroFichier = '19';
  // 2 chiffres, en alpha
  CJour = 19; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour20_1;
Const
  CNumeroFichier = '20';
  // 2 chiffres, en alpha
  CJour = 20; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour20_2;
Const
  CNumeroFichier = '20';
  // 2 chiffres, en alpha
  CJour = 20; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour21_1;
Const
  CNumeroFichier = '21';
  // 2 chiffres, en alpha
  CJour = 21; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour21_2;
Const
  CNumeroFichier = '21';
  // 2 chiffres, en alpha
  CJour = 21; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour22_1;
Const
  CNumeroFichier = '22';
  // 2 chiffres, en alpha
  CJour = 22; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour22_2;
Const
  CNumeroFichier = '22';
  // 2 chiffres, en alpha
  CJour = 22; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour23_1;
Const
  CNumeroFichier = '23';
  // 2 chiffres, en alpha
  CJour = 23; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour23_2;
Const
  CNumeroFichier = '23';
  // 2 chiffres, en alpha
  CJour = 23; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour24_1;
Const
  CNumeroFichier = '24';
  // 2 chiffres, en alpha
  CJour = 24; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour24_2;
Const
  CNumeroFichier = '24';
  // 2 chiffres, en alpha
  CJour = 24; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour25_1;
Const
  CNumeroFichier = '25';
  // 2 chiffres, en alpha
  CJour = 25; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.Jour25_2;
Const
  CNumeroFichier = '25';
  // 2 chiffres, en alpha
  CJour = 25; // Numéro du jour
  CExercice = 2; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
end;
procedure TForm1.OuvreFichier(NomFichier: string);
begin
  FermeFichier;
  assignfile(Fichier, NomFichier);
  reset(Fichier);
  FichierOuvert := NomFichier;
end;
procedure TForm1.TemplateJour;
Const
  CNumeroFichier = '05';
  // 2 chiffres, en alpha
  CJour = 5; // Numéro du jour
  CExercice = 1; // Numéro exercice
var
  PremiereLigneTraitee: boolean;
  Ligne: string;
  Reponse: uint64;
begin
  PremiereLigneTraitee := false;
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
  AfficheResultat(CJour, CExercice, Reponse);
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
end.
