function [s, P_an]  = analit(P_0, a_1, a_0, R, q, u, n)
  s_max_cu = (a_1-a_0)*R;
  h = ( s_max_cu + 300)/(n-1);
  P_an = zeros(n,1);
  P_an(1) = P_0;
  P_an_cu = @(s) R*q*sin(s/R - a_1) +exp(u*s/R)*(P_0 + R*q*sin(a_1));#формула (1.3)
  #для напраленного участка
  P_an_ver = @(s) P_an_cu(s_max_cu) + (s - s_max_cu)*q;#формула (1.2) для
  #для вертивального участка
  s = 0:h:(s_max_cu + 300);#матрица значений длины от расстояния от забоя по шагам
  for i = 2:n #идём от забоя
  if(s(i) < s_max_cu)#пока находимся в напраленно-направленном участке
  #вычисляем по формуле (1.3)
  P_an(i) = P_an_cu(s(i));
else
  P_an(i) = P_an_ver(s(i));#дольше по (1.2)
  endif
endfor
endfunction