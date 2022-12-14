clc;
clear all;
close all;
q = 0.0254;
R = 200;
u = 0.2;
a_0 = 0;
a_1 = pi/2;
P_0 = 0;
n = 100;
#скважина наклонно-направленная, состоит из вертикального участка
#и участка набора угла
s_max_cu = (a_1-a_0)*R; #посчитал длину наклонно-направленного участка
#длина вертикального задана - 300 м
h = ( s_max_cu + 300)/(n-1); #суммарная длина/число шагов=длина шага
dP = @(s, P) q*cos(a_1 - t(s))+u*((P*(a_1-t(s)))/R+q*sin(a_1-t(s)));#
#функция (1.1), но я и её изменил, зависит от параметров s(длина по стволу) и P(нагрузка)
  [s, P_an]  = analit(P_0, a_1, a_0, R, q, u, n); #получаем значения параметров s и P,
  #рассчитанную аналитическим путём из функции "analit", она находится в другом файле (требование матлаба)
P_eu = euler(dP, P_0, n, a_1, a_0, R, u);#P по методу Эйлера
P_eu_hu = euler(dP, P_0, 2*n, a_1, a_0, R, u);#P с уменьшеннум в два раза шагом
#(нужно для рассчёта погрешности)
P_ruku = ruku(dP, P_0, n, a_1, a_0, R, u);#P по методу Рунге-Кутты
temp = zeros(n,1);#матрица нулей размером 1xn
for k=1:n#в матрице значений P_eu_hu в два раза больше столбцов, чем в P_eu
  temp(k) = P_eu_hu(2*k);#вычислил параметр temp равный матрице P_eu_hu, но столбцы через один
  endfor
err = abs(P_eu - temp)/(2^2 - 1);#погрешность по формуле
figure('Name', 'Методы')
plot(s, P_an, ";Аналитический;", s, P_eu, ";Метод Эйлера;", s, P_ruku,";Метод Рунге-Кутты;")
figure('Name', 'Погрешность')
plot(s, err)
