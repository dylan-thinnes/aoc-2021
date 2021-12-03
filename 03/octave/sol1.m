records = 1000;
width = 12;
raw = fileread("../input");
digits = reshape(raw, [width+1, records])(1:width,:) == '1';

probs = mean(digits, dim=2);
binvec = round(probs);

gamma = sum(binvec.' .* 2 .^ flip(0:width-1))
epsilon = 2 ^ width - gamma - 1
gamma * epsilon
