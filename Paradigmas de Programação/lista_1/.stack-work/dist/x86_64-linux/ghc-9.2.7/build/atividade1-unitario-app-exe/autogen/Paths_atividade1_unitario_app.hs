{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_atividade1_unitario_app (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/root/Documents/disciplinas/Paradigmas de Programa\56515\56487\56515\56483o/lista_1/.stack-work/install/x86_64-linux/96c50b1ba1ac6cf64cea48302a707814d6c1bfae9ff624b6557e308cd3bf8ca9/9.2.7/bin"
libdir     = "/root/Documents/disciplinas/Paradigmas de Programa\56515\56487\56515\56483o/lista_1/.stack-work/install/x86_64-linux/96c50b1ba1ac6cf64cea48302a707814d6c1bfae9ff624b6557e308cd3bf8ca9/9.2.7/lib/x86_64-linux-ghc-9.2.7/atividade1-unitario-app-0.1.0.0-3N7cBrNyojWC1ZlCA13FqI-atividade1-unitario-app-exe"
dynlibdir  = "/root/Documents/disciplinas/Paradigmas de Programa\56515\56487\56515\56483o/lista_1/.stack-work/install/x86_64-linux/96c50b1ba1ac6cf64cea48302a707814d6c1bfae9ff624b6557e308cd3bf8ca9/9.2.7/lib/x86_64-linux-ghc-9.2.7"
datadir    = "/root/Documents/disciplinas/Paradigmas de Programa\56515\56487\56515\56483o/lista_1/.stack-work/install/x86_64-linux/96c50b1ba1ac6cf64cea48302a707814d6c1bfae9ff624b6557e308cd3bf8ca9/9.2.7/share/x86_64-linux-ghc-9.2.7/atividade1-unitario-app-0.1.0.0"
libexecdir = "/root/Documents/disciplinas/Paradigmas de Programa\56515\56487\56515\56483o/lista_1/.stack-work/install/x86_64-linux/96c50b1ba1ac6cf64cea48302a707814d6c1bfae9ff624b6557e308cd3bf8ca9/9.2.7/libexec/x86_64-linux-ghc-9.2.7/atividade1-unitario-app-0.1.0.0"
sysconfdir = "/root/Documents/disciplinas/Paradigmas de Programa\56515\56487\56515\56483o/lista_1/.stack-work/install/x86_64-linux/96c50b1ba1ac6cf64cea48302a707814d6c1bfae9ff624b6557e308cd3bf8ca9/9.2.7/etc"

getBinDir     = catchIO (getEnv "atividade1_unitario_app_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "atividade1_unitario_app_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "atividade1_unitario_app_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "atividade1_unitario_app_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "atividade1_unitario_app_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "atividade1_unitario_app_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
