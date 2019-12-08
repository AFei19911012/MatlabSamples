function MatlabWordDemo
% Matlab 操作 Word 文档
filepath = [pwd, '\测试.docx'];  % 设置文件保存路径
% 检查 Word 是否已经打开
try
    % 若 Word 服务器已经打开，返回其句柄
    word = actxGetRunningServer('Word.Application');
catch
    % 创建一个Microsoft Word服务器
    word = actxserver('Word.Application'); 
end;
% 设置 word 属性为可见，0表示不可见
% set(word, 'Visible', 1);
word.Visible = 1;    
% 检查文件是否存在
if exist(filepath, 'file')
    document = word.Documents.Open(filepath);     
    % document = invoke(word.Documents, 'Open', filepath);
else
    document = word.Documents.Add;     
    % Document = invoke(word.Documents, 'Add'); 
    document.SaveAs2(filepath);
end
% 句柄获取
content = document.Content;
selection = word.Selection;    
paragraph_format = selection.ParagraphFormat;  
% 页面设置
document.PageSetup.TopMargin = 60;         % 上边距60磅
document.PageSetup.BottomMargin = 45;   % 下边距45磅
document.PageSetup.LeftMargin = 45;         % 左边距45磅
document.PageSetup.RightMargin = 45;       % 右边距45磅
% 标题
content.Text = 'word测试';
% 设置文档内容的起始位置
content.Start = 0;     
content.Font.Size = 16 ;   % 设置字号为16
content.Font.Bold = 4 ;     % 字体加粗
content.Paragraphs.Alignment = 'wdAlignParagraphCenter';    % 居中对齐
% 设置下面内容的起始位置
selection.Start = content.end;   
% 回车，另起一段
selection.TypeParagraph;    
% 在当前位置输入文字内容
selection.Text = '文字内容1';     
selection.Font.Size = 12;   % 设置字号为12
selection.Font.Bold = 0;     % 字体不加粗
selection.MoveDown;         % 光标下移（取消选中）
paragraph_format.Alignment = 'wdAlignParagraphCenter';    % 居中对齐
selection.TypeParagraph;    
selection.TypeParagraph;    
selection.Font.Size = 10.5; 
% 在光标所在位置插入一个 4 行 3 列的表格
Tables = document.Tables.Add(selection.Range, 4, 3);    
% 返回第1个表格的句柄
table = Tables;
% table = document.Tables.Item(1);   
% 设置表格边框
table.Borders.OutsideLineStyle = 'wdLineStyleSingle';
table.Borders.OutsideLineWidth = 'wdLineWidth150pt';
table.Borders.InsideLineStyle = 'wdLineStyleSingle';
table.Borders.InsideLineWidth = 'wdLineWidth150pt';
table.Rows.Alignment = 'wdAlignRowCenter';
table.Rows.Item(2).Borders.Item(1).LineStyle = 'wdLineStyleNone';
% 设置表格列宽和行高
column_width = [50, 50, 200];    % 定义列宽向量
row_height = [20, 25, 20, 200];    % 定义行高向量
% 设置表格的列宽
for i = 1 : 3
    table.Columns.Item(i).Width = column_width(i);
end
% 设置表格的行高
for i = 1 : 4
    table.Rows.Item(i).Height = row_height(i);
end
% 设置每个单元格的垂直对齐方式
for i = 1 : 4
    for j = 1 : 3
        table.Cell(i,j).VerticalAlignment = 'wdCellAlignVerticalCenter';
    end
end
% 合并单元格
table.Cell(1, 2).Merge(table.Cell(1, 3));
table.Cell(2, 2).Merge(table.Cell(3, 3));
table.Cell(4, 1).Merge(table.Cell(4, 3));
selection.Start = content.end;    
selection.TypeParagraph;         
selection.Text = '文字内容2';    
paragraph_format.Alignment = 'wdAlignParagraphRight';    % 右对齐
selection.MoveDown;   
% 写入表格内容
table.Cell(1, 1).Range.Text = '内容1';
table.Cell(3, 1).Range.Text = '内容2';
table.Cell(1, 1).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
table.Cell(3, 1).VerticalAlignment = 'wdCellAlignVerticalTop';
table.Cell(1, 1).Borders.Item(2).LineStyle = 'wdLineStyleNone';
table.Cell(1, 1).Borders.Item(4).LineStyle = 'wdLineStyleNone';
% 如果当前工作文档中有图形存在，通过循环将图形全部删除
shape = document.Shapes;   
shape_count = shape.Count;   % 返回文档中Shape对象的个数
if shape_count ~= 0
    for i = 1 : shape_count
        shape.Item(1).Delete;  
    end;
end;
% 产生标准正态分布随机数，画直方图，并设置图形属性
fig = figure;
set(fig, 'visible', 'off')
data = normrnd(0, 1, 1000, 1);    
hist(data); 
grid on;     
xlabel('横轴');  
ylabel('纵轴');     
% 图形复制
hgexport(fig, '-clipboard');
% 图形粘贴
% Selection.Range.PasteSpecial;
table.Cell(8,1).Range.Paragraphs.Item(1).Range.Paste;
delete(fig);    % 删除图形句柄
document.ActiveWindow.ActivePane.View.Type = 'wdPrintView';    % 设置视图方式为页面
document.Save;     % 保存文档
document.Close;
word.Quit;