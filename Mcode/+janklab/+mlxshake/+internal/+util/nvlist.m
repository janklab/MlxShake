function out = nvlist(x)
% Convert input to a nvlist (name/value cell row vector).
%
% out = janklab.mlxshake.internal.util.nvlist(x)
%
% Returns a 2n-long cell row vector, or errors out.
%
% TODO: Support strings for names, not just charvecs.

if isstring(x)
    x = cellstr(x);
end

if iscell(x)
    if size(x, 2) == 2
        % It's a cellrec. Validate and convert.
        names = x(:,1);
        if ~iscellstr(names)
            error("Invalid input: Name elements must be charvecs");
        end
        tmp = x';
        out = tmp(:)';
    elseif size(x, 1) == 1
        if mod(numel(x), 2) ~= 0
            error("Invalid input: Cell vector inputs must be 2n long; got a " ...
                + "%d-long cell vector", numel(x));
        end
        names = x(1:2:end);
        if ~iscellstr(names)
            error("Invalid input: Name elements must be charvecs");
        end
        out = x;
    else
        error("Invalid input: Cell inputs must be n-by-2 or a 2n-long row vector; " ...
            + "got a %s cell", janklab.mlxshake.internal.util.size2str(size(x)));
    end
else
    error("Invalid input: Can't convert a %s to an nvlist (name/value cell vector)", ...
        class(x));
end