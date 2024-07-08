unit VersioningRT.FileManager;

interface

uses
  System.SysUtils, System.Classes, System.JSON;
type
  TFileManager = class
  public
    class procedure WriteToFile(const FileName: string; const JSONObject: TJSONObject);
    class function ReadFromFile(const FileName: string): TJSONObject;
  end;
implementation
{ TFileManager }
class procedure TFileManager.WriteToFile(const FileName: string; const JSONObject: TJSONObject);
var
  LFileStream: TFileStream;
  LStreamWriter: TStreamWriter;
begin
  LFileStream := TFileStream.Create(FileName, fmCreate);
  try
    LStreamWriter := TStreamWriter.Create(LFileStream, TEncoding.UTF8);
    try
      LStreamWriter.Write(JSONObject.ToJSON);
    finally
      LStreamWriter.Free;
    end;
  finally
    LFileStream.Free;
  end;
end;

class function TFileManager.ReadFromFile(const FileName: string): TJSONObject;
var
  LFileStream: TFileStream;
  LStreamReader: TStreamReader;
  LJSONString: string;
begin
  Result := nil;
  if not FileExists(FileName) then
    Exit;
  LFileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
  try
    LStreamReader := TStreamReader.Create(LFileStream, TEncoding.UTF8);
    try
      LJSONString := LStreamReader.ReadToEnd;
      Result := TJSONObject.ParseJSONValue(LJSONString) as TJSONObject;
    finally
      LStreamReader.Free;
    end;
  finally
    LFileStream.Free;
  end;
end;
end.
