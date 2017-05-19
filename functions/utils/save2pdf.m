function save2pdf( h, file)
%SAVE2PDF Save figure h to pdf file

parentdir = 'output';

if ~exist(parentdir, 'dir')
   mkdir(parentdir); 
end

path = sprintf('%s/%s', parentdir, file);

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(path, '-dpdf','-r0')
fprintf('Figure saved to file %s.pdf!\n', file)

end

