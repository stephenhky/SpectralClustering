

from itertools import product
from functools import partial

import numpy as np
from scipy.spatial.distance import sqeuclidean, cosine
from scipy.stats import pearsonr
from scipy.sparse import dok_matrix
from tqdm import tqdm

# similarity functions
def gaussian_ij(X, i, j, sigma=0.1):
    return np.exp(-sqeuclidean(X[i, :], X[j, :])/(2*sigma*sigma))


def cosine_ij(X, i, j):
    return 1-cosine(X[i, :], X[j, :])


def corr_ij(X, i, j):
    return pearsonr(X[i, :], X[j, :])


def compute_affinity_matrix(X, simfcn=partial(gaussian_ij, sigma=0.1)):
    nbdata = X.shape[0]
    affmat = dok_matrix((nbdata, nbdata))

    for i, j in product(range(nbdata), range(nbdata)):
        affmat[i, j] = simfcn(X, i, j)

    return affmat


if __name__ == '__main__':
    import argparse

    argparser = argparse.ArgumentParser(description='Output Affinity matrix')
    argparser.add_argument('input_numpyfile', help='path of input numpy file')
    argparser.add_argument('output_file', help='output file')
    argparser.add_argument('type', help='type of stuff')
    argparser.add_argument('threshold', type=float, help='threshold')
    argparser.add_argument('--sigma', type=float, default=0.2236, help='gamma')
    args = argparser.parse_args()

    X = np.load(args.input_numpyfile)

    if args.type == 'gaussian':
        simfcn = partial(gaussian_ij, sigma=args.sigma)
    elif args.type == 'cosine':
        simfcn = cosine_ij
    elif args.type == 'correlation':
        simfcn = partial(corr_ij, sigma=args.sigma)
    else:
        raise Exception('No such similarity function: {}'.format(args.type))

    # compute affinity matrix
    affmat = compute_affinity_matrix(X, simfcn=simfcn)

    # output
    f = open(args.output_file, 'w')
    for i, j in tqdm(affmat.keys()):
        if affmat[i, j] >= args.threshold:
            f.write('{} {}\n'.format(i, j))
    f.close()
