records = 1000;
width = 12;
raw = fileread("../input");
digits = reshape(raw, [width+1, records])(1:width,:) == '1';

oxygen = digits;
co2 = digits;
for bit_idx = 1:width
    prob = mean(oxygen(bit_idx,:), dim=2);
    if size(oxygen, 2) > 1
        oxygen = oxygen(:, oxygen(bit_idx,:) == round(prob));
    end

    prob = mean(co2(bit_idx,:), dim=2);
    if size(co2, 2) > 1
        co2 = co2(:, co2(bit_idx,:) != round(prob));
    end
end

oxygen = sum(oxygen.' .* 2 .^ flip(0:width-1))
co2 = sum(co2.' .* 2 .^ flip(0:width-1))
oxygen * co2
