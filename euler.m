function P = euler(dP, P_0, n, a_1, a_0, R, u)
  P = zeros(n, 1);
  P(1) = P_0;#на забое нагрузка на нижний конец участка равна P_0 = 0
  s_max_cu = (a_1-a_0)*R;
   h = ( s_max_cu + 300)/(n-1);
   s=0:h:(s_max_cu+300);
  for i=2:n
    P(i) = P(i - 1) +dP(s(i-1), P(i - 1)) * h;#нагрузка по методу Эйлера
  endfor
endfunction