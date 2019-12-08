function MatlabWordDemo
% Matlab ���� Word �ĵ�
filepath = [pwd, '\����.docx'];  % �����ļ�����·��
% ��� Word �Ƿ��Ѿ���
try
    % �� Word �������Ѿ��򿪣���������
    word = actxGetRunningServer('Word.Application');
catch
    % ����һ��Microsoft Word������
    word = actxserver('Word.Application'); 
end;
% ���� word ����Ϊ�ɼ���0��ʾ���ɼ�
% set(word, 'Visible', 1);
word.Visible = 1;    
% ����ļ��Ƿ����
if exist(filepath, 'file')
    document = word.Documents.Open(filepath);     
    % document = invoke(word.Documents, 'Open', filepath);
else
    document = word.Documents.Add;     
    % Document = invoke(word.Documents, 'Add'); 
    document.SaveAs2(filepath);
end
% �����ȡ
content = document.Content;
selection = word.Selection;    
paragraph_format = selection.ParagraphFormat;  
% ҳ������
document.PageSetup.TopMargin = 60;         % �ϱ߾�60��
document.PageSetup.BottomMargin = 45;   % �±߾�45��
document.PageSetup.LeftMargin = 45;         % ��߾�45��
document.PageSetup.RightMargin = 45;       % �ұ߾�45��
% ����
content.Text = 'word����';
% �����ĵ����ݵ���ʼλ��
content.Start = 0;     
content.Font.Size = 16 ;   % �����ֺ�Ϊ16
content.Font.Bold = 4 ;     % ����Ӵ�
content.Paragraphs.Alignment = 'wdAlignParagraphCenter';    % ���ж���
% �����������ݵ���ʼλ��
selection.Start = content.end;   
% �س�������һ��
selection.TypeParagraph;    
% �ڵ�ǰλ��������������
selection.Text = '��������1';     
selection.Font.Size = 12;   % �����ֺ�Ϊ12
selection.Font.Bold = 0;     % ���岻�Ӵ�
selection.MoveDown;         % ������ƣ�ȡ��ѡ�У�
paragraph_format.Alignment = 'wdAlignParagraphCenter';    % ���ж���
selection.TypeParagraph;    
selection.TypeParagraph;    
selection.Font.Size = 10.5; 
% �ڹ������λ�ò���һ�� 4 �� 3 �еı��
Tables = document.Tables.Add(selection.Range, 4, 3);    
% ���ص�1�����ľ��
table = Tables;
% table = document.Tables.Item(1);   
% ���ñ��߿�
table.Borders.OutsideLineStyle = 'wdLineStyleSingle';
table.Borders.OutsideLineWidth = 'wdLineWidth150pt';
table.Borders.InsideLineStyle = 'wdLineStyleSingle';
table.Borders.InsideLineWidth = 'wdLineWidth150pt';
table.Rows.Alignment = 'wdAlignRowCenter';
table.Rows.Item(2).Borders.Item(1).LineStyle = 'wdLineStyleNone';
% ���ñ���п���и�
column_width = [50, 50, 200];    % �����п�����
row_height = [20, 25, 20, 200];    % �����и�����
% ���ñ����п�
for i = 1 : 3
    table.Columns.Item(i).Width = column_width(i);
end
% ���ñ����и�
for i = 1 : 4
    table.Rows.Item(i).Height = row_height(i);
end
% ����ÿ����Ԫ��Ĵ�ֱ���뷽ʽ
for i = 1 : 4
    for j = 1 : 3
        table.Cell(i,j).VerticalAlignment = 'wdCellAlignVerticalCenter';
    end
end
% �ϲ���Ԫ��
table.Cell(1, 2).Merge(table.Cell(1, 3));
table.Cell(2, 2).Merge(table.Cell(3, 3));
table.Cell(4, 1).Merge(table.Cell(4, 3));
selection.Start = content.end;    
selection.TypeParagraph;         
selection.Text = '��������2';    
paragraph_format.Alignment = 'wdAlignParagraphRight';    % �Ҷ���
selection.MoveDown;   
% д��������
table.Cell(1, 1).Range.Text = '����1';
table.Cell(3, 1).Range.Text = '����2';
table.Cell(1, 1).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
table.Cell(3, 1).VerticalAlignment = 'wdCellAlignVerticalTop';
table.Cell(1, 1).Borders.Item(2).LineStyle = 'wdLineStyleNone';
table.Cell(1, 1).Borders.Item(4).LineStyle = 'wdLineStyleNone';
% �����ǰ�����ĵ�����ͼ�δ��ڣ�ͨ��ѭ����ͼ��ȫ��ɾ��
shape = document.Shapes;   
shape_count = shape.Count;   % �����ĵ���Shape����ĸ���
if shape_count ~= 0
    for i = 1 : shape_count
        shape.Item(1).Delete;  
    end;
end;
% ������׼��̬�ֲ����������ֱ��ͼ��������ͼ������
fig = figure;
set(fig, 'visible', 'off')
data = normrnd(0, 1, 1000, 1);    
hist(data); 
grid on;     
xlabel('����');  
ylabel('����');     
% ͼ�θ���
hgexport(fig, '-clipboard');
% ͼ��ճ��
% Selection.Range.PasteSpecial;
table.Cell(8,1).Range.Paragraphs.Item(1).Range.Paste;
delete(fig);    % ɾ��ͼ�ξ��
document.ActiveWindow.ActivePane.View.Type = 'wdPrintView';    % ������ͼ��ʽΪҳ��
document.Save;     % �����ĵ�
document.Close;
word.Quit;