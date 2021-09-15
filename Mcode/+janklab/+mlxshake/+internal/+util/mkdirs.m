function mkdirs(dir)
% Create a directory, including all parents.
arguments
    dir (1,1) string
end

%#ok<*AGROW>

dirs = dir;
parent = fileparts(dir);
while ~ismember(parent, dirs)
    dirs(end+1) = parent;
    parent = fileparts(parent);
end
dirs = dirs(end:-1:1);
dirs = dirs(:);

for i = 1:numel(dirs)
    if ~isfolder(dirs(i))
        janklab.mlxshake.internal.util.mkdir2(dirs(i));
    end
end

end

