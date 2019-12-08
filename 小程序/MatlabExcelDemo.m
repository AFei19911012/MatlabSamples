function MatlabExcelDemo
% Matlab ���� Excel �ĵ�
filepath = [pwd, '\����.xlsx'];   % �����ļ�����·��
% ��� Excel �Ƿ��Ѿ���
try
    % �� Excel �������Ѿ��򿪣���������
    excel = actxGetRunningServer('Excel.Application');
catch
    % ����һ��Microsoft Excel ������ 
    excel = actxserver('Excel.Application'); 
end;
% ���� excel ����Ϊ�ɼ���0��ʾ���ɼ�
% set(excel, 'Visible', 1);
excel.Visible = 0; 
excel.DisplayAlerts = false;   % ȡ��������ʾ
% ����ļ��Ƿ����
if exist(filepath, 'file')
    workbook = excel.Workbooks.Open(filepath);
    % workbook = invoke(excel.Workbooks, 'Open', filepath);
else
    workbook = excel.Workbooks.Add;
    % workbook = invoke(excel.Workbooks, 'Add');
    workbook.SaveAs(filepath);
end
% ��ǰ��������
sheets = excel.ActiveWorkbook.Sheets;    
% sheets = workbook.Sheets;
sheet1 = sheets.Item(1);    % ���ص�1��Sheet���
sheet1.Activate;    % �����1�����
sheet1.Name = 'text';  % �޸ĵ�1��Sheet������
% ҳ������
sheet1.PageSetup.TopMargin = 5;          % �ϱ߾�5��
sheet1.PageSetup.BottomMargin = 10;      % �±߾�10��
sheet1.PageSetup.LeftMargin = 15;        % ��߾�15��
sheet1.PageSetup.RightMargin = 20;       % �ұ߾�20��
% �����иߺ��п�
% �����и�����RowHeight
RowHeight = [40, 15, 40, 15];
sheet1.Range('A1:A4').RowHeight = RowHeight;
sheet1.Range('A1:C1').ColumnWidth = [40, 10, 45, 15];
% �ϲ���Ԫ��
sheet1.Range('A1:C1').MergeCells = 1;
sheet1.Range('A3:C3').MergeCells = 1;
% ���õ�Ԫ��ı߿�
sheet1.Range('A1:B1').Borders.Weight = 3;
sheet1.Range('A4:C4').Borders.Item(3).Linestyle = 0;
sheet1.Range('A4:C4').Borders.Item(4).Linestyle = 0;
% ���õ�Ԫ����뷽ʽ
sheet1.Range('A1:B3').HorizontalAlignment = 3;
sheet1.Range('C1:C3').VerticalAlignment = 1;
% д�뵥Ԫ������
sheet1.Range('A1').Value = '����';
% �����ֺ�
sheet1.Range('A1:B3').Font.size = 10.5; 
sheet1.Range('A1').Font.size = 16;        
sheet1.Range('A1').Font.bold = 2;         
% �����ǰ�����ĵ�����ͼ�δ��ڣ�ͨ��ѭ����ͼ��ȫ��ɾ��
shape = sheet1.Shapes;   
shape_count = shape.Count;   % �����ĵ���Shape����ĸ���
% while shape_count > 0
%     shape.Item(1).Delete; 
% end
if shape_count ~= 0
    for i = 1 : shape_count
        shape.Item(1).Delete;  
    end;
end;
% ����һ��Figure
fig = figure;
set(fig, 'visible', 'off')
peaks(40);     
% ͼ�θ���
hgexport(fig, '-clipboard');
% ͼ��ճ��
% ѡ�� sheet1 �� D3 ��Ԫ�񣬲���ֱ��ͼ
sheet1.Range('D3').Select;
sheet1.Paste    
% sheet1.PasteSpecial;
delete(fig);    % ɾ��ͼ�ξ��
workbook.Save   % �����ĵ�
workbook.Close;
excel.Quit;