src = strsplit(fileread("../input"), "\n\n");
callouts = str2num(src{1,1});
cboards = cellfun(@str2num, src(1,2:end), 'UniformOutput', false);
for i = 1:length(cboards)
  boards(i,1:25) = cboards{i}(:);
end

row_kernels = ones(5,1) * (1:5);

row1 = 1 == row_kernels;
row2 = 2 == row_kernels;
row3 = 3 == row_kernels;
row4 = 4 == row_kernels;
row5 = 5 == row_kernels;

col1 = row1';
col2 = row2';
col3 = row3';
col4 = row4';
col5 = row5';

kernels = cat(2
    ,row1(:), row2(:), row3(:), row4(:), row5(:)
    ,col1(:), col2(:), col3(:), col4(:), col5(:)
  );

board_flags = false(size(boards));

for callout = callouts
  board_flags = board_flags | boards == callout;
  winners = any(board_flags * kernels == 5, 2);
  if any(winners)
    break
  end
end

sum((boards .* !board_flags)(winners,:)) * callout
