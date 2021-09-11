function str = processIncludedGraphics(str, format, png2jpeg, filename, filepath)
% Process included graphics
%
% Note: There are two cases in the tex
% 1: inserted image: \includegraphics[width=\maxwidth{64.52584044154541em}]{image_0}
% 2: generated figure: \includegraphics[width=\maxwidth{52.78474661314601em}]{figure_0.png}
%
% Inserted images needs to ???
arguments
    str string
    format (1,1) string
    png2jpeg (1,1) logical
    filename (1,1) string
    filepath (1,1) string
end

LF = newline;

% markdown (GitHub): ![string]('path to a image')
% latex では \includegraphics[width=\maxwidth{56.196688409433015em}]{filename}
tfImage = contains(str, "\includegraphics");
imageParts = str(tfImage);

% When exported latex from live script, figures and inserted images
% are saved in 'imagedir' as image files.
% latex を生成した時点で Figure 等は画像としてimagedir に保存されている
imageDir = filename + "_images/";
imageDir = strrep(imageDir, '\', '/');

% for each images
for i = 1:length(imageParts)
    % Detect the actual filename with extention
    filenames = regexp(imageParts(i), "\\includegraphics\[[^\]]+\]{([^{}]+)}", "tokens");
    [~, fileStem, ~] = fileparts(filenames{:});
    fileGlob = fullfile(filepath, imageDir, fileStem + ".*");
    imageFilename = ls(fileGlob); 
    
    % Compress PNG images as JPEG
    if png2jpeg
        [~,imageFileStem,ext] = fileparts(imageFilename);
        if strcmp(ext,'.png')
            I = imread(fullfile(imageDir, imageFilename));
            imageFilename = [imageFileStem '_png.jpg'];
            imwrite(I, fullfile(imageDir, imageFilename), 'Quality', 85);
        end
    end
    
    switch format
        case 'github'
            %  ![string]('path to a image')
            imageParts(i) = regexprep(imageParts(i), "\\includegraphics\[[^\]]+\]{"+filenames{:}+"}",...
                "![" + imageFilename + "](" + imageDir + imageFilename + ")");

        case 'qiita'
            % Qiita に移行する際は、画像ファイルを該当箇所に drag & drop する必要
            % 幅指定する場合には
            % <img src="" alt="attach:cat" title="attach:cat" width=500px>
            imageParts(i) = regexprep(imageParts(i), "\\includegraphics\[[^\]]+\]{" + filenames{:} + "}",...
                "<--" + LF ...
                + "**Please drag & drop an image file here**" + LF ...
                + "Filename: **" + imageDir + imageFilename + "**" + LF ...
                + "If you want to set the image size use the following command" + LF ...
                + "<img src="" alt=""attach:cat"" title=""attach:cat"" width=500px>" + LF ...
                + "-->");
    end
end

str(tfImage) = imageParts;
