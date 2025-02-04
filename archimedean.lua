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
        
        self.axes:add(sym:orbit(sym.xoo.unit):named({
            BRU = {3, 'FRD'},
            FLU = {1, 'FRU'},
            BLU = {3, 'FLD'},
            FRD = {2, 'FLU'},
            FRU = {},
            BRD = {2, 'BLU'},
            FLD = {1, 'FRD'},
            BLD = {1, 'BRD'},
        }), {INF, hex_d - 1/3})
        self.axes:add(sym:orbit(sym.oox.unit):named({
            F = {},
            U = {3, 'F'},
            R = {2, 'U'},
            L = {1, 'R'},
            D = {2, 'L'},
            B = {3, 'D'},
          }), {INF, square_d - 1/4})
        
        for _, a, t in sym.chiral:orbit(self.axes[sym.xoo], sym:thru(3,2)) do
            self.twists:add(a, t, { gizmo_pole_distance = hex_d })
        end
        for _, a, t in sym.chiral:orbit(self.axes[sym.oox], sym:thru(2,1)) do
            self.twists:add(a, t, { gizmo_pole_distance = square_d })
        end

        lib.utils.unpack_named(_ENV, self.axes)
        self:mark_piece(F(1) & ~FLU(1) & ~FLD(1) & ~FRU(1) & ~FRD(1), 'square_center', 'Square Center')
        self:mark_piece(FLU(1) & ~F(1) & ~L(1) & ~U(1) & ~FRU(1) & ~FLD(1) & ~BLU(1), 'hex_center', 'Hexagon Center')
        self:mark_piece(F(1) & FLU(1) & ~FLD(1) & ~FRU(1), 'square_edge', 'Square Edge')
        self:mark_piece(FLU(1) & FRU(1) & ~F(1) & ~U(1), 'hex_edge', 'Hexagon Edge')
        self:mark_piece(F(1) & FLU(1) & FRU(1), 'corner', 'Corner')
        self:unify_piece_types(sym.chiral)
    end
}