function MatlabExcelDemo
% Matlab 操作 Excel 文档
filepath = [pwd, '\测试.xlsx'];   % 设置文件保存路径
% 检查 Excel 是否已经打开
try
    % 若 Excel 服务器已经打开，返回其句柄
    excel = actxGetRunningServer('Excel.Application');
catch
    % 创建一个Microsoft Excel 服务器 
    excel = actxserver('Excel.Application'); 
end;
% 设置 excel 属性为可见，0表示不可见
% set(excel, 'Visible', 1);
excel.Visible = 0; 
excel.DisplayAlerts = false;   % 取消保存提示
% 检查文件是否存在
if exist(filepath, 'file')
    workbook = excel.Workbooks.Open(filepath);
    % workbook = invoke(excel.Workbooks, 'Open', filepath);
else
    workbook = excel.Workbooks.Add;
    % workbook = invoke(excel.Workbooks, 'Add');
    workbook.SaveAs(filepath);
end
% 当前工作表句柄
sheets = excel.ActiveWorkbook.Sheets;    
% sheets = workbook.Sheets;
sheet1 = sheets.Item(1);    % 返回第1个Sheet句柄
sheet1.Activate;    % 激活第1个表格
sheet1.Name = 'text';  % 修改第1个Sheet的名字
% 页面设置
sheet1.PageSetup.TopMargin = 5;          % 上边距5磅
sheet1.PageSetup.BottomMargin = 10;      % 下边距10磅
sheet1.PageSetup.LeftMargin = 15;        % 左边距15磅
sheet1.PageSetup.RightMargin = 20;       % 右边距20磅
% 设置行高和列宽
% 定义行高向量RowHeight
RowHeight = [40, 15, 40, 15];
sheet1.Range('A1:A4').RowHeight = RowHeight;
sheet1.Range('A1:C1').ColumnWidth = [40, 10, 45, 15];
% 合并单元格
sheet1.Range('A1:C1').MergeCells = 1;
sheet1.Range('A3:C3').MergeCells = 1;
% 设置单元格的边框
sheet1.Range('A1:B1').Borders.Weight = 3;
sheet1.Range('A4:C4').Borders.Item(3).Linestyle = 0;
sheet1.Range('A4:C4').Borders.Item(4).Linestyle = 0;
% 设置单元格对齐方式
sheet1.Range('A1:B3').HorizontalAlignment = 3;
sheet1.Range('C1:C3').VerticalAlignment = 1;
% 写入单元格内容
sheet1.Range('A1').Value = '内容';
% 设置字号
sheet1.Range('A1:B3').Font.size = 10.5; 
sheet1.Range('A1').Font.size = 16;        
sheet1.Range('A1').Font.bold = 2;         
% 如果当前工作文档中有图形存在，通过循环将图形全部删除
shape = sheet1.Shapes;   
shape_count = shape.Count;   % 返回文档中Shape对象的个数
% while shape_count > 0
%     shape.Item(1).Delete; 
% end
if shape_count ~= 0
    for i = 1 : shape_count
        shape.Item(1).Delete;  
    end;
end;
% 生成一个Figure
fig = figure;
set(fig, 'visible', 'off')
peaks(40);     
% 图形复制
hgexport(fig, '-clipboard');
% 图形粘贴
% 选中 sheet1 的 D3 单元格，插入直方图
sheet1.Range('D3').Select;
sheet1.Paste    
% sheet1.PasteSpecial;
delete(fig);    % 删除图形句柄
workbook.Save   % 保存文档
workbook.Close;
excel.Quit;