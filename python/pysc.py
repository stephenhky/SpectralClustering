
from itertools import product

import numpy as np
from scipy.sparse import dok_matrix
from scipy.sparse.linalg import eigs
from scipy.spatial.distance import sqeuclidean
from sklearn.cluster import k_means


def compute_affinity_matrix(X, sigma=0.1):
    nbdata = X.shape[0]
    affmat = dok_matrix((nbdata, nbdata))
    squared_sigma = sigma * sigma

    for i, j in product(range(nbdata), range(nbdata)):
        affmat[i, j] = np.exp(-sqeuclidean(X[i, :], X[j, :])/(2*squared_sigma))

    return affmat


def normalize_matrix(sqmat):
    assert sqmat.shape[0] == sqmat.shape[1]

    degrees = np.sum(sqmat, axis=1)
    L = dok_matrix(sqmat.shape)
    for i, j in sqmat.keys():
        L[i, j] = sqmat[i, j] * np.sqrt(degrees[i]*degrees[j])

    return L


def get_spectral_vectors(L, k):
    _, eigvecs = eigs(L, k=k)
    return eigvecs


class SpectralClustering:
    def __init__(self, nbcluster, sigma, k):
        self.nbcluster = nbcluster
        self.sigma = sigma
        self.k = k
        self.fit = False

    def fit(self, X):
        A = compute_affinity_matrix(X, sigma=self.sigma)
        L = normalize_matrix(A)
        redL = get_spectral_vectors(L, k=self.k)
        centroids, labels, inertia = k_means(redL, n_clusters=self.nbcluster)

        self.affinity_matrix = A
        self.redL = redL
        self.centroids = centroids
        self.labels = labels
        self.inertia = inertia

        return centroids, labels


# scikit-learn: sklearn.cluster.SpectralClustering
# https://scikit-learn.org/stable/modules/generated/sklearn.cluster.SpectralClustering.html
# put gamma = 10 for our dataset
