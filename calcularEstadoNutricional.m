function [imc, z, estado] = calcularEstadoNutricional(edadSemanas, sexo, pesoLb, tallaCm, rutaExcel)
    % Carga tablas OMS
    tablaIMC_boys = readtable(fullfile(rutaExcel, 'bmi_boys_0-to-13-weeks_zscores.xlsx'));
    tablaIMC_girls = readtable(fullfile(rutaExcel, 'bmi_girls_0-to-13-weeks_zscores.xlsx'));

    % Convertir unidades
    pesoKg = pesoLb * 0.453592;
    tallaM = tallaCm / 100;

    % Calcular IMC
    imc = pesoKg / (tallaM^2);

    % Seleccionar tabla según sexo
    if strcmpi(sexo, 'Masculino') || strcmpi(sexo, 'M')
        tablaIMC = tablaIMC_boys;
    elseif strcmpi(sexo, 'Femenino') || strcmpi(sexo, 'F')
        tablaIMC = tablaIMC_girls;
    else
        error('Sexo inválido. Debe ser Masculino o Femenino.');
    end

    % Buscar fila más cercana
    [~, idx] = min(abs(tablaIMC.Week - edadSemanas));

    L = tablaIMC.L(idx);
    M = tablaIMC.M(idx);
    S = tablaIMC.S(idx);

    % Calcular z-score usando función auxiliar externa
    z = calculaZscore(L, M, S, imc);

    % Determinar estado
    if z > 2
        estado = 'Obeso';
    elseif z < -2
        estado = 'Desnutrición';
    else
        estado = 'Normal';
    end
end

function zval = calculaZscore(Lval, Mval, Sval, X)
    if Lval == 0
        zval = log(X / Mval) / Sval;
    else
        zval = ((X / Mval)^Lval - 1) / (Lval * Sval);
    end
end
