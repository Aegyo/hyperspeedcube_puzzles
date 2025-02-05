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

function icosidodecahedron(scale, basis)
    
    local s = scale or 1
    local dodeca_d = s
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
