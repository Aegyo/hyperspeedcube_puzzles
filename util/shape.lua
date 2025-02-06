function truncated_tetrahedron(scale, basis)
    local s = scale or 1
    local sym = cd('a3', basis)
    local hex_pole = sym.xoo.unit * s
    local tri_pole = sym.oox.unit * s * 5/3
    return {
        name = 'truncated_tetrahedron',
        sym = sym,
        hex_pole = hex_pole,
        tri_pole = tri_pole,

        iter_hex_poles = function(self, prefix)
            return self.sym.chiral:orbit(self.hex_pole)
        end,
        iter_tri_poles = function(self, prefix)
            return self.sym.chiral:orbit(self.tri_pole)
        end,
    }
end

function truncated_octahedron(scale, basis)
    local sym = cd('bc3', basis)
    local s = scale or 1
    local hex_pole = sym.xoo.unit * s
    local square_pole = sym.oox.unit * s * 2 / sqrt(3)
    return {
        name = 'truncated_octahedron',
        sym = sym,
        hex_pole = hex_pole,
        square_pole = square_pole,

        iter_hex_poles = function(self, prefix)
            return self.sym.chiral:orbit(self.hex_pole):named({
                BRU = {3, 'FRD'},
                FLU = {1, 'FRU'},
                BLU = {3, 'FLD'},
                FRD = {2, 'FLU'},
                FRU = {},
                BRD = {2, 'BLU'},
                FLD = {1, 'FRD'},
                BLD = {1, 'BRD'},
            })
        end,
        iter_square_poles = function(self, prefix)
            return self.sym.chiral:orbit(self.square_pole):named({
                F = {},
                U = {3, 'F'},
                R = {2, 'U'},
                L = {1, 'R'},
                D = {2, 'L'},
                B = {3, 'D'},
              })
        end,
    }
end

function icosidodecahedron(scale, alt_scale, basis)
    
    local s = scale or 1
    local dodeca_d = alt_scale or s
    local icosa_d = s * sqrt((7+3*sqrt(5))/6) / sqrt((5 + 2*sqrt(5))/5)

    local dodeca = lib.symmetries.h3.dodecahedron(dodeca_d, basis)
    local icosa = lib.symmetries.h3.icosahedron(icosa_d, basis)

    return {
        name = 'icosidodecahedron',
        sym = dodeca.sym,
        penta_pole = dodeca.sym.oox.unit * dodeca_d,
        tri_pole = icosa.sym.xoo.unit * icosa_d,

        iter_penta_poles = function(self, prefix)
            return dodeca:iter_poles(prefix)
        end,
        iter_tri_poles = function(self, prefix)
            return icosa:iter_poles(prefix)
        end,
    }
end

function rhombic_triacontahedron(scale, basis)
    local s = scale or 1

    local dual = icosidodecahedron(1, basis)
    local hex1 = dual.penta_pole
    local hex2 = dual.sym:thru(3,2):transform(dual.penta_pole)
    local tri = dual.tri_pole

    local dual_corner = vec(plane(hex1):antiwedge(plane(hex2)):antiwedge(plane(tri)))
    local pole = s * dual_corner.unit / dual_corner.mag

    return {
        name = 'rhombic_triacontahedron',
        sym = dual.sym,
        pole = pole,
        iter_poles = function()
            return dual.sym:orbit(pole)
        end
    }
end

function rhombicosidodecahedron(scale, basis)
    local base = icosidodecahedron(0.786, 0.84, basis)
    local dual = rhombic_triacontahedron(1, basis)

    return {
        penta_pole = base.penta_pole,
        tri_pole = base.tri_pole,
        square_pole = dual.pole,
        sym = base.sym,

        iter_penta_poles = base.iter_penta_poles,
        iter_tri_poles = base.iter_tri_poles,
        iter_square_poles = dual.iter_poles,
    }
end

function truncated_icosahedron(scale, basis)
    local s = scale or 1
    local icosa_d = s
    local dodeca_d = s * sqrt((3/2) * (7 + 3*sqrt(5))) / (sqrt((125 + 41*sqrt(5))/10) * 0.95)

    local dodeca = lib.symmetries.h3.dodecahedron(dodeca_d, basis)
    local icosa = lib.symmetries.h3.icosahedron(icosa_d, basis)

    return {
        name = 'truncated_icosahedron',
        sym = dodeca.sym,
        penta_pole = dodeca.sym.oox.unit * dodeca_d,
        hex_pole = icosa.sym.xoo.unit * icosa_d,

        iter_penta_poles = function(self, prefix)
            return dodeca:iter_poles(prefix)
        end,
        iter_hex_poles = function(self, prefix)
            return icosa:iter_poles(prefix)
        end,
    }
end