puzzles:add{
    id = 'truncated_octahedron',
    name = 'Truncated Octahedron',
    version = '0.1.0',
    ndim = 3,
    tags = { author = { 'Jessica Chen' } },
    build = function(self)
        local sym = cd'bc3'
        
        local hex_d = sqrt(6)/2
        local square_d = sqrt(2)
        self:carve(sym:orbit(sym.xoo.unit*hex_d))
        self:carve(sym:orbit(sym.oox.unit*square_d))
        
        self.axes:add(sym:orbit(sym.xoo.unit), {INF, hex_d - 1/3})
        self.axes:add(sym:orbit(sym.oox.unit), {INF, square_d - 1/4})
        
        for _, a, t in sym:orbit(self.axes[sym.xoo], sym:thru(3,2)) do
            self.twists:add(a, t, { gizmo_pole_distance = hex_d })
        end
        for _, a, t in sym:orbit(self.axes[sym.oox], sym:thru(2,1)) do
            self.twists:add(a, t, { gizmo_pole_distance = square_d })
        end
    end
}