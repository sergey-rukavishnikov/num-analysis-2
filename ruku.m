function P = ruku(dP, P_0, n, a_1, a_0, R, u)
  P = zeros(n, 1);
  P(1) = P_0;
  s_max_cu = (a_1-a_0)*R;
   h = ( s_max_cu + 300)/(n-1);
   s=0:h:(s_max_cu+300);
  for i=2:n#все формулы из метода Рунге-Кутты
    k_0 = dP(s(i-1), P(i -1)) * h;
    k_1 = dP((s(i-1)+h/2), (P(i - 1)+k_0/2)) * h;
    k_2 = dP((s(i-1)+h/2), (P(i - 1)+k_1/2)) * h;
    k_3 = dP((s(i-1)+h), (P(i - 1)+k_2)) * h;
    P(i) = P(i - 1) +(k_0+2*k_1+2*k_2+k_3)/6;
  endfor
endfunction