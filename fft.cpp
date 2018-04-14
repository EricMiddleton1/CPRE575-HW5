#include <complex>
#include <vector>
#include <iostream>

using FFTSample = std::complex<double>;

void fft(std::vector<FFTSample>& values);
void ifft(std::vector<FFTSample>& values);

void shuffle(std::vector<FFTSample>& values);
void merge(std::vector<FFTSample>& values);
void swap(FFTSample& a, FFTSample& b);
size_t reverse(size_t in, size_t bits);

std::ostream& operator<<(std::ostream& os, const std::vector<FFTSample>& samples);

int main() {
  const double sq2 = std::sqrt(2.)/2.;

  std::vector<FFTSample> samples{
    {0., 0.}, {sq2, 0.}, {1., 0.}, {sq2, 0.}, {0., 0.}, {-sq2, 0.}, {-1., 0.}, {-sq2, 0}
  };

  std::cout << "Performing FFT on input vector: " << samples << std::endl;

  //In-place FFT
  fft(samples);

  std::cout << "\nFFT result vector: " << samples << std::endl;

  //In-place Inverse FFT
  ifft(samples);

  std::cout << "\nIFFT result vector: " << samples << std::endl;

  return 0;
}

void fft(std::vector<FFTSample>& values) {
  //First, rearrange the input vector (in place)
  shuffle(values);

  //Second, perform merge
  merge(values);

  //That's it!
}

void ifft(std::vector<FFTSample>& values) {
  //Conjugate input
  for(auto& value : values) {
    value = std::conj(value);
  }

  //Perform regular FFT
  fft(values);

  //Conjugate result, divide by N
  for(auto& value : values) {
    value = std::conj(value) / std::complex<double>(values.size(), 0.);
  }
}

void shuffle(std::vector<FFTSample>& values) {
  //Determine total number of bits
  size_t bits, size = values.size();
  for(bits = 0; size > 0; size >>= 1, ++bits);
  --bits;

  //Shuffle FFT input samples by swapping each sample with the value at the bit
   //reversed index
  for(size_t i = 0; i < values.size(); ++i) {
    auto rev = reverse(i, bits);
    if(i < rev) {
      swap(values[i], values[rev]);
    }
  }
}

void merge(std::vector<FFTSample>& values) {
  const double PI = 3.141592654;

  for(size_t m = 2; m <= values.size(); m <<= 1) {
    //Calculate twiddle factor
    auto w = std::exp(std::complex<double>{0., -2. * PI / m});
    std::complex<double> v{1., 0.};

    //Butterfly merge
    for(size_t k = 0; k < m/2; ++k) {
      for(size_t i = 0; i < values.size(); i += m) {
        //Calculate butterfly indicies
        auto p = k + i;
        auto q = p + m/2;

        //Perform operations
        auto a = values[p];
        auto b = values[q] * v;
        values[p] = a + b;
        values[q] = a - b;
      }
      v *= w;
    }
  }
}

void swap(FFTSample& a, FFTSample& b) {
  auto t = a;
  a = b;
  b = t;
}

size_t reverse(size_t in, size_t bits) {
  size_t rev = 0;

  for(auto i = 0; i < bits; ++i) {
    rev <<= 1;
    rev |= (in >> i) & 0x1;
  }

  return rev;
}

std::ostream& operator<<(std::ostream& os, const std::vector<FFTSample>& samples) {
  os << "{";

  if(!samples.empty()) {
    for(auto i = 0; i < samples.size()-1; ++i) {
      os << samples[i] << ", ";
    }
    os << samples.back();
  }

  os << "}";

  return os;
}
