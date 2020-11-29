; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Kivy Easier"
#define MyAppVersion "2"
#define MyAppPublisher "Nathan Ara�jo"
#define MyAppURL "https://github.com/ntaraujo/kivy-easier"
#define MyAppExeName "Kivy-Easier.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{0CB8BD9E-F07A-4771-83A5-A809391CF3A8}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={commonpf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=C:\Users\Nathan\Documents\GitHub\kivy-easier\LICENSE
OutputDir=C:\Users\Nathan\Documents\GitHub\kivy-easier\dev\v2
OutputBaseFilename=ke-installer
SetupIconFile=C:\Users\Nathan\Documents\GitHub\kivy-easier\dev\logo.ico
Compression=lzma2/ultra64
SolidCompression=yes
LZMAUseSeparateProcess=yes
LZMADictionarySize=1048576
LZMANumFastBytes=273

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "armenian"; MessagesFile: "compiler:Languages\Armenian.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "icelandic"; MessagesFile: "compiler:Languages\Icelandic.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "slovak"; MessagesFile: "compiler:Languages\Slovak.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "C:\Users\Nathan\Documents\GitHub\kivy-easier\dev\Kivy-Easier.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Nathan\Documents\GitHub\kivy-easier\dev\v2\rootfs.tar.gz"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Nathan\Documents\GitHub\kivy-easier\bin\*"; DestDir: "{app}\bin"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"
Filename: "{app}\Kivy-Easier.exe"; Parameters: "install"; Flags: waituntilterminated; Description: "Extract rootfs.tar.gz and register on WSL"
Filename: "{app}\Kivy-Easier.exe"; Parameters: "run pacman-key --init"; Flags: waituntilterminated; Description: "Keyring Part 1"
Filename: "{app}\Kivy-Easier.exe"; Parameters: "run pacman-key --populate"; Flags: waituntilterminated; Description: "Keyring Part 2"
Filename: "{app}\Kivy-Easier.exe"; Parameters: "config --default-user ke"; Flags: waituntilterminated; Description: "Configure default user"
Filename: "{app}\Kivy-Easier.exe"; Parameters: "run /home/ke/wadb-settings.sh y"; Description: "ADB Workarounds settings"
Filename: "{app}\Kivy-Easier.exe"; Parameters: "run /home/ke/wadb-run.sh upgrade"; Description: "Installing Windows version of ADB"

[Registry]
Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}\bin"; \
    Check: NeedsAddPath('{app}\bin')

[UninstallDelete]
Type: files; Name: "{app}\Kivy-Easier.exe"
Type: filesandordirs; Name: "{app}\*"
Type: files; Name: "{app}\rootfs.tar.gz"

[UninstallRun]
Filename: "cmd.exe"; Parameters: "/c 'echo ""y"" | {app}\Kivy-Easier.exe clean'"; Flags: waituntilterminated; RunOnceId: "WSLUnregister"

[Code]

function NeedsAddPath(Param: string): boolean;
var
  OrigPath: string;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE,
    'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
    'Path', OrigPath)
  then begin
    Result := True;
    exit;
  end;
  { look for the path with leading and trailing semicolon }
  { Pos() returns 0 if not found }
  Result := Pos(';' + Param + ';', ';' + OrigPath + ';') = 0;
end;