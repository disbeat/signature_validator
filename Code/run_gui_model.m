function [ results, avg ] = run_gui_model( handles )

    set(handles.evaluate, 'String', 'Running...');
    set(handles.evaluate, 'Enable', 'off');

    try 

        sets = get(handles.lstSets, 'Value');

        useAutomatic = get(handles.optAutomatic, 'Value');
        attrs = str2num( [ '0' get(handles.txtAttrs, 'String') ] );

        features = {};
        if get(handles.chkSix, 'Value') features = [features 'sixfold']; end;
        if get(handles.chkLength, 'Value') features = [features 'length']; end;
        if get(handles.chkBF, 'Value') features = [features 'bestfit']; end;
        if get(handles.chkSplit, 'Value') features = [features 'splitting']; end;
        if get(handles.chkTri, 'Value') features = [features 'trisurface']; end;
        if get(handles.chkCentroid, 'Value') features = [features 'centroid']; end;
        if get(handles.chkMDF, 'Value') features = [features 'mdf']; end;
        if get(handles.chkStroke, 'Value') features = [features 'stroke']; end;
        if get(handles.chkHistogram, 'Value') features = [features 'histogram']; end;

        contents = cellstr(get(handles.lstClassifiers,'String'));
        classifier = cell2mat(contents(get(handles.lstClassifiers, 'Value')));

        folds = str2num( [ '0' get(handles.folds, 'String') ] );


        % all data is gathered from gui at this point


        addpath 'classifiers';
        addpath 'performance';
        load 'images_data.mat'

        set(handles.lstResults, 'String', 'Loading features...');
        drawnow;

        selected_images_data = [];
        for s = sets
            selected_images_data = [selected_images_data; images_data(s*54 : (s+1)*54-1, :)];
        end

        selected_features = [];
        if (useAutomatic)
            if (get(handles.optMI, 'Value'))
                selected_features = [ apply_mi(selected_images_data(:, 1:end-1), attrs) selected_images_data(:, end) ];
            else
                selected_features = [ apply_cov(selected_images_data(:, 1:end-1), attrs) selected_images_data(:, end) ];
            end
        else
            selected_features = [ get_features_by_name(selected_images_data, features) selected_images_data(:, end) ];
        end

        name = sprintf('%s_classifier', classifier);
        func = str2func(name);

        set(handles.lstResults, 'String', 'Running the classifier...');
        drawnow;

        [train_indexes, test_indexes] = crossval(size(selected_features, 1), folds);      

        results = [];
        for fold = 1 : folds
            train_data = selected_features(cell2mat(train_indexes(fold)), :);
            train_struct = stprstruct(train_data);
            test_data = selected_features(cell2mat(test_indexes(fold)), :);
            test_struct = stprstruct(test_data);
            quality = func(train_struct, test_struct);

            results = [ results; quality.F quality.ACCURACY quality.RECALL quality.PRECISION ];

            if (fold == 1)
                set(handles.lstResults, 'String', {});  
            end

            line = sprintf('Fold %d: %.2f%% accuracy, %.2f%% Precision, %.2f%% Recall, %.2f%% F-score', [fold quality.ACCURACY*100 quality.PRECISION*100 quality.RECALL*100 quality.F*100] );
            set(handles.lstResults, 'String', [get(handles.lstResults, 'String'); line]);

            set(handles.txtFScore, 'String', sprintf('%.1f%%', mean(results(:, 1) * 100)));
            set(handles.txtAcc, 'String', sprintf('%.1f%%', mean(results(:, 1) * 100)));
            set(handles.txtRecall, 'String', sprintf('%.1f%%', mean(results(:, 1) * 100)));
            set(handles.txtPrecision, 'String', sprintf('%.1f%%', mean(results(:, 1) * 100)));
            
            drawnow;

        end
    
    catch exception
       
        msgbox(exception, 'Error', 'error', 'modal');
    
    end
        
    set(handles.evaluate, 'String', 'Evaluate');
    set(handles.evaluate, 'Enable', 'on');

    
end

