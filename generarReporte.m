function generarReporte(ax, data)
    % Filtrar datos del mes actual
    fechas = datetime(data.fecha_guardado, 'InputFormat', 'yyyy-MM-dd HH:mm:ss'); % Ajusta formato si necesario
    mesActual = month(datetime('now'));
    aoActual = year(datetime('now'));

    idxMes = (month(fechas) == mesActual) & (year(fechas) == añoActual);
    dataMes = data(idxMes, :);

    if isempty(dataMes)
        uialert(ax.Parent, 'No hay datos para el mes actual.', 'Aviso');
        cla(ax)
        return
    end

    estados = dataMes.EstadoNutricional;
    estadosCat = categorical(estados);
    counts = countcats(estadosCat);
    categorias = categories(estadosCat);

    % Graficar
    bar(ax, counts)
    ax.XTickLabel = categorias;
    ax.XTickLabelRotation = 45;
    title(ax, sprintf('Reporte Mensual: %s %d', datestr(datetime('now'),'mmmm'), añoActual))
    xlabel(ax, 'Estado Nutricional')
    ylabel(ax, 'Cantidad')
    grid(ax, 'on');

    % Guardar en PDF
    fig = figure('Visible', 'off');
    bar(counts)
    set(gca, 'XTickLabel', categorias, 'XTickLabelRotation', 45)
    title(sprintf('Reporte Mensual: %s %d', datestr(datetime('now'),'mmmm'), añoActual))
    xlabel('Estado Nutricional')
    ylabel('Cantidad')
    grid on

    nombreArchivo = sprintf('Reporte_Mensual_%s_%d.pdf', datestr(datetime('now'),'mmmm'), añoActual);
    print(fig, nombreArchivo, '-dpdf')
    close(fig)

    uialert(ax.Parent, ['Reporte guardado como: ', nombreArchivo], 'Reporte generado')
end