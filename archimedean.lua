puzzles:add{
    id = 'truncated_tetrahedron',
    name = 'Truncated Tetrahedron',
    version = '0.1.0',
    ndim = 3,
    build = function(self)
        local sym = cd'a3'

        local trunc_d = 5/3
        self:carve(sym:orbit(sym.xoo.unit))
        self:carve(sym:orbit(sym.oox.unit*trunc_d))

        self.axes:add(sym.chiral:orbit(sym.xoo.unit), { INF, 0.7 })
        self.axes:add(sym.chiral:orbit(sym.oox.unit), { INF, 0.8 * trunc_d })

        for _, a, t in sym.chiral:orbit(self.axes[sym.xoo], sym:thru(3,2)) do
            self.twists:add(a, t, {gizmo_pole_distance = 1})
        end
        for _, a, t in sym.chiral:orbit(self.axes[sym.oox], sym:thru(2,1)) do
            self.twists:add(a, t, {gizmo_pole_distance = trunc_d})
        end
    end,
    tags = {
        author = { 'Jessica Chen' }
    }
}

puzzles:add{
    id = 'truncated_octahedron',
    name = 'Truncated Octahedron',
    version = '0.1.0',
    ndim = 3,
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
    end,
    tags = {
        author = { 'Jessica Chen' },
        'shape/3d/archimedean'
    },
}

puzzles:add{
    id = 'icosidodecahedron',
    name = 'Icosidodecahedron',
    version = '0.1.0',
    ndim = 3,
    build = function(self)
        local sym = cd'h3'

        local dodeca_d = sqrt((5 + 2*sqrt(5))/5)
        local icosa_d = sqrt((7+3*sqrt(5))/6)

        local dodeca = lib.symmetries.h3.dodecahedron(dodeca_d)
        local icosa = lib.symmetries.h3.icosahedron(icosa_d)

        self:carve(dodeca:iter_poles('Penta_'))
        self:carve(icosa:iter_poles('Tri_'))

        self.axes:add(dodeca:iter_poles('Penta_'), { INF, dodeca_d * 0.85 })
        self.axes:add(icosa:iter_poles('Tri_'), { INF, icosa_d * 0.925 })
        
        for _, a, t in sym.chiral:orbit(self.axes[sym.oox], sym:thru(2,1)) do
            self.twists:add(a, t, { gizmo_pole_distance = dodeca_d })
        end
        for _, a, t in sym.chiral:orbit(self.axes[sym.xoo], sym:thru(3,2)) do
            self.twists:add(a, t, { gizmo_pole_distance = icosa_d })
        end
        
        lib.utils.unpack_named(_ENV, self.axes)
        self:mark_piece(Penta_F(1) & ~Tri_U(1) & ~Tri_F(1) & ~Tri_R(1) & ~Tri_UR(1) & ~Tri_FR(1), 'penta_center', 'Pentagon Center')
        self:mark_piece(Penta_F(1) & Penta_L(1) & Penta_DL(1), 'tri_center', 'Triangle Center')
        self:mark_piece(Penta_F(1) & Tri_U(1) & ~Penta_L(1) & ~Penta_U(1), 'two_col_edge', '2C Edge')
        self:mark_piece(Tri_U(1) & Penta_F(1) & Penta_L(1) & ~Tri_F(1) & ~Penta_U(1), 'three_col_edge', '3C Edge')
        self:mark_piece(Penta_F(1) & Penta_L(1) & Tri_F(1) & Tri_U(1), 'corner', 'Corner')
        self:unify_piece_types(sym.chiral)

        for i = 1,12 do
            self.colors[i].default = 'Turbo[' .. i ..'/12]'
        end
        for i = 13,32 do
            self.colors[i].default = 'Dark Rainbow['.. i ..'/20]'
        end
    end,
    tags = {
        author = { 'Jessica Chen' },
        'shape/3d/archimedean'
    },
}