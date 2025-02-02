puzzle_generators:add{
    id = 'bipyramid',
    version = '0.1.0',
    name = 'N-gonal Bipyramid',
    tags = {
        author = { 'Jessica Chen' }
    },
    params = {
        { name = 'Pyramid Base Edges', type = 'int', default = 3, min = 3, max = 20},
    },
    gen = function(params)
        local n = params[1]
        return {
            name = n .. '-BiPyramid',
            ndim = 3,
            build = function(self)
                local up = vec(0, 1, 0)
                local edge = vec(1, 1, 1) - up
                local r = rot{fix = up, angle = tau/n}
                local m1 = refl(plane(up))

                local sym = symmetry({m1, r})
                local pole = (edge + (up * n / 6)) / 3

                self:carve(sym:orbit(pole))

                local belt_edge = edge / 3
                local v_corner = up

                for _, a in sym:orbit(belt_edge) do
                    self.axes:add(a, { INF, 2/3 - 1/n})
                end
                for _, a in sym:orbit(v_corner) do
                    self.axes:add(a, {INF, 0})
                end

                for _, a, t in sym:orbit(self.axes[belt_edge]) do
                    self.twists:add(a, rot{fix = a, angle = tau/2}, {gizmo_pole_distance=sqrt(3)* sqrt(n)/6})
                end
                for _, a in sym:orbit(self.axes[v_corner]) do
                    self.twists:add(a, rot{fix = a, angle = tau/n}, {gizmo_pole_distance = 1/2 })
                end
            end
        }
    end,

    examples = {
        { params = {3}, name = 'Triagonal Bipyramid' },
        { params = {5}, name = 'Pentagonal Bipyramid' },
        { params = {12}, name = 'Dodecagonal Bipyramid' },
    }
}