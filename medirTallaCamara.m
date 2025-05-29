function talla = medirTallaCamara()
    try
        cam = webcam;

        fig = figure('Name', 'Medir Talla', 'NumberTitle', 'off');
        hImg = imshow(snapshot(cam));
        title('Presiona una tecla para capturar');

        while ishandle(fig)
            img = snapshot(cam);
            hImg.CData = img;
            drawnow;
            if ~isempty(get(fig, 'CurrentCharacter'))
                break;
            end
        end

        imgFinal = snapshot(cam);
        close(fig);
        clear cam;

        % Aquí iría la lógica real con visión por computadora.
        talla = 85 + randi(15);  % Simulación de talla

    catch ME
        disp(['Error con la cámara: ', ME.message]);
        talla = NaN;
    end
end
