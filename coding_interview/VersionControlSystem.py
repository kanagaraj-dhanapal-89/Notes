class VersionControlManagement(object):

    def __init__(self, number_of_versions):
        self.number_of_versions = number_of_versions
        self.adj_matrix = [[-1] * self.number_of_versions for x in range(number_of_versions)]
        self.vertices = {}
        self.verticesList = [0] * number_of_versions

    def set_versions(self, vtx, version):
        if 0 <= vtx <= self.number_of_versions:
            self.vertices[version] = vtx
            self.verticesList[vtx] = version

    def set_version_map(self, frm, to, cost=1):
        frm = self.vertices[frm]
        to = self.vertices[to]
        self.adj_matrix[frm][to] = cost

    def get_matrix(self):
        return self.adj_matrix


if __name__ == "__main__":
    vr = VersionControlManagement(5)
    vr.set_versions(0, 1.0)
    vr.set_versions(1, 1.1)
    vr.set_versions(2, 1.2)
    vr.set_versions(3, 1.3)
    vr.set_versions(4, 2.1)
    vr.set_version_map(1.0, 1.1, 1)
    vr.set_version_map(1.1, 1.2, 1)
    vr.set_version_map(1.2, 1.3, 1)
    vr.set_version_map(1.3, 2.1, 1)
    print(vr.get_matrix())

