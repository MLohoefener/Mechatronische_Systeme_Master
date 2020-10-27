function idx = ifmember (x, T)
% instead of ismember in pole_place
% 12.11.2018 T. Brezina + M. Lohöfener, HoMe Merseburg

  idx = false (size(x))';
  for i = 1:length (x)
    for k = 1:length (T)
      if x(i)==T(k)
      idx(i) = true;
    end
  end
end
