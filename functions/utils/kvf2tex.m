function kvf2tex(fin, fout, rootkey)

    if nargin > 2
       rootkey = [rootkey '.'];
    else
        rootkey = '';
    end

    TEMPLATE = '\\@lookupPut{%s}{%s}\n';
    hfin = fopen(fin, 'r');
    hfout = fopen(fout, 'w+');
    
    data = textscan(hfin, '%s = %s');
    
    keys = data{1,1};
    values = data{1,2};
    
    fprintf(hfout, '\\makeatletter\n');
    for i = 1:length(keys)
       fprintf(hfout, TEMPLATE,...
           [rootkey cell2mat(keys(i))], cell2mat(values(i)));
    end
    fprintf(hfout, '\\makeatother\n');
    
    fclose(hfin);
    fclose(hfout);
end