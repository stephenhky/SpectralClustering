
import numpy as np

def generate_spherical_layers(nblayers, nbdata, seed=None):
    if seed is not None:
        np.random.seed(seed)

    all_points = None
    nbpts_per_layer = nbdata // nblayers
    for r in range(1, nblayers+1):
        radii = r + np.random.normal(scale=0.05, size=nbpts_per_layer)
        theta = np.random.uniform(high=np.pi, size=nbpts_per_layer)
        phi = np.random.uniform(high=2*np.pi, size=nbpts_per_layer)

        points = np.array([radii*np.sin(theta)*np.cos(phi),
                           radii*np.sin(theta)*np.sin(phi),
                           radii*np.cos(theta)]).T

        if all_points is None:
            all_points = points
        else:
            all_points = np.append(all_points, points, axis=0)

    return all_points


def generate_circular_layers(nblayers, nbdata, seed=None):
    if seed is not None:
        np.random.seed(seed)

    all_points = None
    nbpts_per_layer = nbdata // nblayers
    for r in range(1, nblayers+1):
        radii = r + np.random.normal(scale=0.05, size=nbpts_per_layer)
        theta = np.random.uniform(high=2*np.pi, size=nbpts_per_layer)

        points = np.array([radii*np.cos(theta),
                           radii*np.sin(theta)]).T

        if all_points is None:
            all_points = points
        else:
            all_points = np.append(all_points, points, axis=0)

    return all_points


def generate_gaussian_mixtures(nbclusters, nbdata, nbdim=2, numerical_ranges=(-10., 10), scale=1.0):
    centroids = np.random.uniform(low=numerical_ranges[0],
                                  high=numerical_ranges[1],
                                  size=nbdim*nbclusters).\
        resize((nbclusters, nbdim))

    points = np.zeros((nbdata, nbdim))
    cluster_choices = np.random.choice(range(nbclusters), size=nbdata)
    for i in range(nbdata):
        points[i, :] = np.random.multivariate_normal(mean=centroids[cluster_choices[i], :],
                                                     cov=np.diag([scale]*nbdim))

    return points
